view: view360 {
  derived_table: {
    sql: SELECT
       ROW_NUMBER () OVER (PARTITION BY correo ORDER BY correo) AS rownumberCorreo
      ,* FROM ${cdp_synapse_clientes_productivos.SQL_TABLE_NAME}
      LEFT JOIN ${cdp_soriana_tipos_usuarios.SQL_TABLE_NAME}
      ON (cdp_synapse_clientes_productivos.GRClienteId = cdp_soriana_tipos_usuarios.GR_Cliente_Id )
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: rownumber_correo {
    type: number
    sql: ${TABLE}.rownumberCorreo ;;
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

  dimension: gr_cliente_id {
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

  dimension: rownumber {
    type: number
    sql: ${TABLE}.rownumber ;;
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

  dimension: id_cliente {
    type: string
    sql: ${TABLE}.idCliente ;;
  }


  dimension: id_tienda {
    type: string
    sql: ${TABLE}.idTienda ;;
  }

  dimension: fecha_nacimiento_soriana {
    type: string
    sql: ${TABLE}.fechaNacimientoSoriana ;;
  }

  dimension: origen_cliente {
    type: string
    sql: ${TABLE}.origenCliente ;;
  }

  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: ticke_total {
    type: number
    sql: ${TABLE}.tickeTotal ;;
  }

  dimension: conteo_compras {
    type: number
    sql: ${TABLE}.conteoCompras ;;
  }

  dimension: ticket_promedio_cliente {
    type: number
    sql: ${TABLE}.ticketPromedioCliente ;;
  }

  dimension: store_location {
    type: location
    sql_latitude: ${TABLE}.Latitud ;;
    sql_longitude: ${TABLE}.Longitud ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  set: detail {
    fields: [
      rownumber_correo,
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
      gr_cliente_id,
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
      rownumber,
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
      id_cliente,
      id_tienda,
      fecha_nacimiento_soriana,
      origen_cliente,
      semana,
      ticke_total,
      conteo_compras,
      ticket_promedio_cliente,
      store_location,
      tipo_cliente
    ]
  }
}
