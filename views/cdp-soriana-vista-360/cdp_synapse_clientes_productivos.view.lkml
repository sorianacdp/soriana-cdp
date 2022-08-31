view: cdp_synapse_clientes_productivos {
  derived_table: {
    sql: with rango_fecha as (
      select
          format_date('%Y%m%d',date_sub(current_date(), interval 3 month)) as fecha_inicio,
          format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) as fecha_final
),engagement as (
      select
            (select distinct value.int_value from unnest(event_params) where key = 'ga_session_id') as session_id,
            max((select value.int_value from unnest(event_params) where key = 'engagement_time_msec')) as engagement_time_msec,
      from
              -- change this to your google analytics 4 export location in bigquery
          `costumer-data-proyect.analytics_249184604.events_*`,
          rango_fecha
      where
            _table_suffix between rango_fecha.fecha_inicio and rango_fecha.fecha_final and event_name IN ('view_item_list', 'view_item', 'add_to_wishlist', 'add_to_cart','list_add_to_cart','remove_from_cart','begin_checkout','purchase','search','select_content','click')
      group by session_id
),sessiones as (
      select
          distinct PARSE_DATE("%Y%m%d",event_date) as fecha,
          platform as plataforma,
          ifnull(user_id,'(not set)') as usuarioLogueado,
          ifnull(user_pseudo_id,'(not set)') as usuarioNoLogueado,
          #### eventos
          event_name as nombreEvento,
          --detalles generales
          ifnull((select value.int_value from unnest(event_params) where key = 'ga_session_id'),0) as idSesion,
          ifnull((select value.int_value from unnest(event_params) where key = 'ga_session_number'),0) as numeroSesion,
          TIMESTAMP_MICROS(event_timestamp) as tiempoEvento,
          --view item list
           ifnull((select value.string_value from unnest(event_params) where key = 'firebase_event_origin'),'(not set)') as origenEventoFirebase,
           ifnull(items.item_id,'(not set)') as idArticulo,
           ifnull(items.item_name,'(not set)')  as nombreArticulo,
           ifnull(items.item_brand,'(not set)') as marcaArticulo,
           ifnull(items.item_list_id,'(not set)') as listaArticuloId,
           ifnull(items.item_list_name,'(not set)') as listaArticuloNombre,
          --event cart
          ifnull((select value.string_value from unnest(event_params) where key = 'transaction_id'),'(not set)') as idTransaccion,
          case
          when geo.region='' then '(not set)'
          when geo.region is null then '(not set)'
          else geo.region
          end as estadoGeo,
          case
          when geo.city='' then '(not set)'
          when geo.city is null then '(not set)'
          else geo.city
          end as ciudadGeo,
          case
          when geo.country='' then '(not set)'
          when geo.country is null then '(not set)'
          else geo.country
          end as paisGeo
      from
          `costumer-data-proyect.analytics_249184604.events_*`,rango_fecha, unnest(items) as items
      WHERE
         _table_suffix between rango_fecha.fecha_inicio and rango_fecha.fecha_final and event_name IN ('view_item_list', 'view_item', 'add_to_wishlist', 'add_to_cart','list_add_to_cart','remove_from_cart','begin_checkout','purchase')
         and platform in ('IOS', 'ANDROID','WEB')
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
      order by  fecha desc, nombreEvento
      ),sesionDuracion as (
      select
          sessiones.fecha,
          sessiones.usuarioLogueado,
          sessiones.idSesion,
          sessiones.idArticulo,
          sessiones.numeroSesion,
          sessiones.idTransaccion,
          if(sessiones.idTransaccion = '(not set)', 1, 0) as busquedas,
          if(sessiones.idTransaccion != '(not set)', 1, 0) as compras,
          sessiones.estadoGeo,
          sessiones.ciudadGeo,
          sessiones.paisGeo,
          engagement.engagement_time_msec
      from sessiones
      inner join engagement on engagement.session_id = sessiones.idSesion
      where engagement.engagement_time_msec is not null and sessiones.usuarioLogueado is not null and sessiones.usuarioLogueado !='(not set)'
),sesionPerUsuario as (
      SELECT
          sesionDuracion.fecha,
          sesionDuracion.usuarioLogueado,
          sesionDuracion.idSesion,
          sum(sesionDuracion.busquedas) busquedas,
          sum(sesionDuracion.compras) compras,
          if(sum(sesionDuracion.compras) = 0, 1,0) as sesionIncompleta,
          if(sum(sesionDuracion.compras) > 0, 1,0) as sesionConCompra,
          sesionDuracion.engagement_time_msec/1000 as DuracionMin,
          sesionDuracion.estadoGeo,
          sesionDuracion.ciudadGeo,
          sesionDuracion.paisGeo
      FROM sesionDuracion
      GROUP BY sesionDuracion.fecha,sesionDuracion.usuarioLogueado, sesionDuracion.idSesion,sesionDuracion.engagement_time_msec,sesionDuracion.estadoGeo,sesionDuracion.ciudadGeo,sesionDuracion.paisGeo
      ORDER BY sesionDuracion.usuarioLogueado
),sessioneCompletas as (
      select
          sesionPerUsuario.fecha as fechaEventos,
          sesionPerUsuario.usuarioLogueado,
          count(sesionPerUsuario.idSesion) as TotalSesiones,
          sum(sesionPerUsuario.busquedas) as ProductosBuscados,
          sum(sesionPerUsuario.sesionConCompra) as SesionesConCompras,
          sum(sesionPerUsuario.compras) as ProductosComprados,
          if(sum(sesionPerUsuario.compras)> 0,sum(sesionPerUsuario.busquedas)/sum(sesionPerUsuario.compras),0) as BusquedasSobreCompras,
          sum(sesionPerUsuario.sesionIncompleta) as SesionesSinCompras,
          sesionPerUsuario.DuracionMin as TiempoTotal,
          sesionPerUsuario.DuracionMin/count(sesionPerUsuario.idSesion) as promedioTiempoSesion,
          sesionPerUsuario.estadoGeo,
          sesionPerUsuario.ciudadGeo,
          sesionPerUsuario.paisGeo
      from sesionPerUsuario
      group by sesionPerUsuario.usuarioLogueado,sesionPerUsuario.fecha,sesionPerUsuario.DuracionMin,sesionPerUsuario.estadoGeo,
          sesionPerUsuario.ciudadGeo,
          sesionPerUsuario.paisGeo
)

      SELECT * FROM `customer_data_platform.cdp_synapse_clientes_productivos` LEFT JOIN sessioneCompletas ON sessioneCompletas.usuarioLogueado=GAUserId ORDER BY sessioneCompletas.  usuarioLogueado desc
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: correo {
    type: string
    sql: ${TABLE}.correo ;;
  }

  dimension: id_cliente_sk {
    type: number
    sql: ${TABLE}.idClienteSk ;;
  }

  dimension: id_cliente_digital {
    type: number
    sql: ${TABLE}.idClienteDigital ;;
  }

  dimension: id_cliente_prog_recompensas {
    type: number
    sql: ${TABLE}.idClienteProgRecompensas ;;
  }

  dimension: id_cliente_membresias {
    type: string
    sql: ${TABLE}.idClienteMembresias ;;
  }

  dimension: id_cliente_setc {
    type: string
    sql: ${TABLE}.idClienteSETC ;;
  }

  dimension: id_cliente_sorianacom {
    type: string
    sql: ${TABLE}.idClienteSorianacom ;;
  }

  dimension: id_cliente_city_web {
    type: string
    sql: ${TABLE}.idClienteCityWeb ;;
  }

  dimension: id_cliente_sfcc {
    type: string
    sql: ${TABLE}.idClienteSFCC ;;
  }

  dimension: gauser_id {
    type: string
    sql: ${TABLE}.GAUserId ;;
  }

  dimension: sfcustomer_no {
    type: string
    sql: ${TABLE}.SFCustomerNo ;;
  }

  dimension: grcliente_id {
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
  }

  dimension: nombre {
    type: string
    sql: ${TABLE}.nombre ;;
  }

  dimension: apellido_paterno {
    type: string
    sql: ${TABLE}.apellidoPaterno ;;
  }

  dimension: apellido_materno {
    type: string
    sql: ${TABLE}.apellidoMaterno ;;
  }

  dimension_group: fecha_nacimiento {
    type: time
    datatype: datetime
    sql: ${TABLE}.fechaNacimiento ;;
  }

  dimension: sexo {
    type: string
    sql: ${TABLE}.sexo ;;
  }

  dimension: cuenta_bancaria {
    type: string
    sql: ${TABLE}.cuentaBancaria ;;
  }

  dimension: telefono_particular {
    type: string
    sql: ${TABLE}.telefonoParticular ;;
  }

  dimension: telefono_celular {
    type: number
    sql: ${TABLE}.telefonoCelular ;;
  }

  dimension: calle {
    type: string
    sql: ${TABLE}.calle ;;
  }

  dimension: colonia {
    type: string
    sql: ${TABLE}.colonia ;;
  }

  dimension: poblacion {
    type: string
    sql: ${TABLE}.poblacion ;;
  }

  dimension: estado {
    type: string
    sql: ${TABLE}.estado ;;
  }

  dimension: codigo_postal {
    type: number
    sql: ${TABLE}.codigoPostal ;;
  }

  dimension_group: fecha_alta {
    type: time
    datatype: datetime
    sql: ${TABLE}.fechaAlta ;;
  }

  dimension: es_empleado_soriana {
    type: yesno
    sql: ${TABLE}.esEmpleadoSoriana ;;
  }

  dimension_group: fecha_creacion {
    type: time
    datatype: datetime
    sql: ${TABLE}.fechaCreacion ;;
  }

  dimension_group: ultima_modificacion {
    type: time
    datatype: datetime
    sql: ${TABLE}.ultimaModificacion ;;
  }

  dimension: id_cliente_perfil_sk {
    type: number
    sql: ${TABLE}.idClientePerfilSk ;;
  }

  dimension: antiguedad_cliente {
    type: number
    sql: ${TABLE}.antiguedadCliente ;;
  }

  dimension: num_saldo_puntos {
    type: number
    sql: ${TABLE}.numSaldoPuntos ;;
  }

  dimension_group: fecha_primera_compra {
    type: time
    datatype: datetime
    sql: ${TABLE}.fechaPrimeraCompra ;;
  }

  dimension_group: fecha_ultima_compra {
    type: time
    datatype: datetime
    sql: ${TABLE}.fechaUltimaCompra ;;
  }

  dimension: ticket_promedio {
    type: number
    sql: ${TABLE}.ticketPromedio ;;
  }

  dimension: origen {
    type: string
    sql: ${TABLE}.origen ;;
  }

  dimension: compra_mayor {
    type: number
    sql: ${TABLE}.compraMayor ;;
  }

  dimension: num_visitas {
    type: number
    sql: ${TABLE}.numVisitas ;;
  }

  dimension: is_insertsfmc {
    type: string
    sql: ${TABLE}.isInsertsfmc ;;
  }

  dimension: validacion_nombre {
    type: number
    sql: ${TABLE}.validacionNombre ;;
  }

  dimension: validacion_apellido_paterno {
    type: number
    sql: ${TABLE}.validacionApellidoPaterno ;;
  }

  dimension: validacion_apellido_materno {
    type: number
    sql: ${TABLE}.validacionApellidoMaterno ;;
  }

  dimension: validacion_correo {
    type: number
    sql: ${TABLE}.validacionCorreo ;;
  }

  dimension: validacion_fecha_nacimiento {
    type: number
    sql: ${TABLE}.validacionFechaNacimiento ;;
  }

  dimension: validacion_sexo {
    type: number
    sql: ${TABLE}.validacionSexo ;;
  }

  dimension: validacion_estado {
    type: number
    sql: ${TABLE}.validacionEstado ;;
  }

  dimension: validacion_codigo_postal {
    type: number
    sql: ${TABLE}.validacionCodigoPostal ;;
  }

  dimension: validacion_telefono_fijo {
    type: number
    sql: ${TABLE}.validacionTelefonoFijo ;;
  }

  dimension: validacion_telefono_celular {
    type: number
    sql: ${TABLE}.validacionTelefonoCelular ;;
  }

  dimension: validacion_duplicados {
    type: number
    sql: ${TABLE}.validacionDuplicados ;;
  }

  dimension_group: fecha_creacion_cdp {
    type: time
    datatype: datetime
    sql: ${TABLE}.FechaCreacionCDP ;;
  }

  dimension: ultima_modificacion_cdp {
    type: string
    sql: ${TABLE}.UltimaModificacionCDP ;;
  }

  dimension: coindicencia_sfccclientes_sfccinvitados {
    type: number
    sql: ${TABLE}.coindicenciaSFCCClientesSFCCInvitados ;;
  }

  dimension: fecha_eventos {
    type: date
    datatype: date
    sql: ${TABLE}.fechaEventos ;;
  }

  dimension: usuario_logueado {
    type: string
    sql: ${TABLE}.usuarioLogueado ;;
  }

  dimension: total_sesiones {
    type: number
    sql: ${TABLE}.TotalSesiones ;;
  }

  dimension: productos_buscados {
    type: number
    sql: ${TABLE}.ProductosBuscados ;;
  }

  dimension: sesiones_con_compras {
    type: number
    sql: ${TABLE}.SesionesConCompras ;;
  }

  dimension: productos_comprados {
    type: number
    sql: ${TABLE}.ProductosComprados ;;
  }

  dimension: busquedas_sobre_compras {
    type: number
    sql: ${TABLE}.BusquedasSobreCompras ;;
  }

  dimension: sesiones_sin_compras {
    type: number
    sql: ${TABLE}.SesionesSinCompras ;;
  }

  dimension: tiempo_total {
    type: number
    sql: ${TABLE}.TiempoTotal ;;
  }

  dimension: promedio_tiempo_sesion {
    type: number
    sql: ${TABLE}.promedioTiempoSesion ;;
  }

  dimension: estadoGeo {
    type: string
    sql: ${TABLE}.estadoGeo ;;
  }

  dimension: ciudadGeo {
    type: string
    sql: ${TABLE}.ciudadGeo ;;
  }

  dimension: paisGeo {
    type: string
    sql: ${TABLE}.paisGeo ;;
  }

  set: detail {
    fields: [
      correo,
      id_cliente_sk,
      id_cliente_digital,
      id_cliente_prog_recompensas,
      id_cliente_membresias,
      id_cliente_setc,
      id_cliente_sorianacom,
      id_cliente_city_web,
      id_cliente_sfcc,
      gauser_id,
      sfcustomer_no,
      grcliente_id,
      advertising_id,
      nombre,
      apellido_paterno,
      apellido_materno,
      fecha_nacimiento_time,
      sexo,
      cuenta_bancaria,
      telefono_particular,
      telefono_celular,
      calle,
      colonia,
      poblacion,
      estado,
      codigo_postal,
      fecha_alta_time,
      es_empleado_soriana,
      fecha_creacion_time,
      ultima_modificacion_time,
      id_cliente_perfil_sk,
      antiguedad_cliente,
      num_saldo_puntos,
      fecha_primera_compra_time,
      fecha_ultima_compra_time,
      ticket_promedio,
      origen,
      compra_mayor,
      num_visitas,
      is_insertsfmc,
      validacion_nombre,
      validacion_apellido_paterno,
      validacion_apellido_materno,
      validacion_correo,
      validacion_fecha_nacimiento,
      validacion_sexo,
      validacion_estado,
      validacion_codigo_postal,
      validacion_telefono_fijo,
      validacion_telefono_celular,
      validacion_duplicados,
      fecha_creacion_cdp_time,
      ultima_modificacion_cdp,
      coindicencia_sfccclientes_sfccinvitados,
      fecha_eventos,
      usuario_logueado,
      total_sesiones,
      productos_buscados,
      sesiones_con_compras,
      productos_comprados,
      busquedas_sobre_compras,
      sesiones_sin_compras,
      tiempo_total,
      promedio_tiempo_sesion,
      estadoGeo,
      ciudadGeo,
      paisGeo
    ]
  }
}
