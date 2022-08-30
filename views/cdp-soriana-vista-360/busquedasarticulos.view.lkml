view: busquedasarticulos {
  derived_table: {
    sql: -- GA4 eventos usuarios: add cart
      with rango_fecha as (
      select
          '20220706' as fecha_inicio,
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
            _table_suffix between rango_fecha.fecha_inicio and rango_fecha.fecha_final
         group by session_id
      )
      ,sessiones as (select
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
      ifnull((select value.string_value from unnest(event_params) where key = 'transaction_id'),'(not set)') as idTransaccion
      from
      `costumer-data-proyect.analytics_249184604.events_*`,rango_fecha, unnest(items) as items
      WHERE
      _table_suffix between rango_fecha.fecha_inicio and rango_fecha.fecha_final and event_name IN ('view_item_list', 'view_item', 'add_to_wishlist', 'add_to_cart','list_add_to_cart','remove_from_cart','begin_checkout','purchase')
      and platform in ('IOS', 'ANDROID','WEB')
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
      order by  fecha desc, nombreEvento
      ),sesionDuracion as (
      select
      sessiones.usuarioLogueado,
      sessiones.idSesion,
      sessiones.idArticulo,
      sessiones.nombreArticulo,
      sessiones.marcaArticulo,
      sessiones.listaArticuloId,
      sessiones.listaArticuloNombre,
      sessiones.numeroSesion,
      sessiones.idTransaccion,
      if(sessiones.idTransaccion = '(not set)', 1, 0) as busquedas,
      if(sessiones.idTransaccion != '(not set)', 1, 0) as compras,
      engagement.engagement_time_msec
      from sessiones
      inner join engagement on engagement.session_id = sessiones.idSesion
      where engagement.engagement_time_msec is not null and sessiones.usuarioLogueado is not null and sessiones.usuarioLogueado !='(not set)'
      ),sesionPerUsuario as (
      SELECT
      sesionDuracion.usuarioLogueado,
      sesionDuracion.idSesion,
      sesionDuracion.idArticulo,
      sesionDuracion.nombreArticulo,
      sesionDuracion.marcaArticulo,
      sesionDuracion.listaArticuloId,
      sesionDuracion.listaArticuloNombre,
      sum(sesionDuracion.busquedas) busquedas,
      sum(sesionDuracion.compras) compras,
      if(sum(sesionDuracion.compras) = 0, 1,0) as sesionIncompleta,
      if(sum(sesionDuracion.compras) > 0, 1,0) as sesionConCompra,
      max(sesionDuracion.engagement_time_msec)/1000 as DuracionMin
      FROM sesionDuracion
      GROUP BY 1,2,3,4,5,6,7
      ORDER BY sesionDuracion.usuarioLogueado
      )
      --SELECT * FROM sesionPerUsuario
      SELECT * FROM `customer_data_platform.cdp_synapse_clientes_productivos` LEFT JOIN sesionPerUsuario ON sesionPerUsuario.usuarioLogueado=GAUserId ORDER BY sesionPerUsuario.DuracionMin desc
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

  dimension: usuario_logueado {
    type: string
    sql: ${TABLE}.usuarioLogueado ;;
  }

  dimension: id_sesion {
    type: number
    sql: ${TABLE}.idSesion ;;
  }

  dimension: id_articulo {
    type: string
    sql: ${TABLE}.idArticulo ;;
  }

  dimension: nombre_articulo {
    type: string
    sql: ${TABLE}.nombreArticulo ;;
  }

  dimension: marca_articulo {
    type: string
    sql: ${TABLE}.marcaArticulo ;;
  }

  dimension: lista_articulo_id {
    type: string
    sql: ${TABLE}.listaArticuloId ;;
  }

  dimension: lista_articulo_nombre {
    type: string
    sql: ${TABLE}.listaArticuloNombre ;;
  }

  dimension: busquedas {
    type: number
    sql: ${TABLE}.busquedas ;;
  }

  dimension: compras {
    type: number
    sql: ${TABLE}.compras ;;
  }

  dimension: sesion_incompleta {
    type: number
    sql: ${TABLE}.sesionIncompleta ;;
  }

  dimension: sesion_con_compra {
    type: number
    sql: ${TABLE}.sesionConCompra ;;
  }

  dimension: duracion_min {
    type: number
    sql: ${TABLE}.DuracionMin ;;
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
      usuario_logueado,
      id_sesion,
      id_articulo,
      nombre_articulo,
      marca_articulo,
      lista_articulo_id,
      lista_articulo_nombre,
      busquedas,
      compras,
      sesion_incompleta,
      sesion_con_compra,
      duracion_min
    ]
  }
}
