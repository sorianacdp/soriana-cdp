view: vista_360_complemento {
  derived_table: {
    sql: Select * from cdp-soriana-vista-360
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: plataformaAndroid {
    type: count_distinct
    sql: ${TABLE}.idClienteSk ;;
    filters: [plataforma: "ANDROID"]
  }
  measure: plataformaIOS {
    type: count_distinct
    sql: ${TABLE}.idClienteSk ;;
    filters: [plataforma: "IOS"]
  }
  measure: plataformaWEB {
    type: count_distinct
    sql: ${TABLE}.idClienteSk ;;
    filters: [plataforma: "WEB"]
  }

  dimension: rownumber_correo {
    type: number
    sql: ${TABLE}.RownumberCorreo ;;
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
    type: string
    sql: ${TABLE}.idClienteProgRecompensas ;;
  }

  dimension: id_cliente_membresias {
    type: number
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
    type: number
    sql: ${TABLE}.telefonoParticular ;;
  }

  dimension: telefono_celular {
    type: string
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

  dimension: fecha_alta {
    type: string
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

  dimension: fecha_primera_compra {
    type: string
    sql: ${TABLE}.fechaPrimeraCompra ;;
  }

  dimension: fecha_ultima_compra {
    type: string
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

  dimension_group: fecha_creacion_cdp {
    type: time
    datatype: datetime
    sql: ${TABLE}.FechaCreacionCDP ;;
  }

  dimension_group: ultima_modificacion_cdp {
    type: time
    datatype: datetime
    sql: ${TABLE}.UltimaModificacionCDP ;;
  }

  dimension: rownumber_sesiones_ga {
    type: number
    sql: ${TABLE}.RownumberSesionesGA ;;
  }

  dimension: semana_sesiones_ga {
    type: number
    sql: ${TABLE}.SemanaSesionesGA ;;
  }

  dimension: plataforma {
    type: string
    sql: ${TABLE}.plataforma ;;
  }

  dimension: usuario_logueado {
    type: string
    sql: ${TABLE}.usuarioLogueado ;;
  }

  dimension: tipo_sesion {
    type: string
    sql: ${TABLE}.TipoSesion ;;
  }

  dimension: busquedas {
    type: number
    sql: ${TABLE}.busquedas ;;
  }

  dimension: compras {
    type: number
    sql: ${TABLE}.compras ;;
  }

  dimension: media_source {
    type: string
    sql: ${TABLE}.mediaSource ;;
  }

  dimension: tiempo_engagement_min {
    type: number
    sql: ${TABLE}.tiempoEngagementMin ;;
  }

  dimension: estados_sesiones {
    sql: ${TABLE}.estadoSesion ;;
    map_layer_name: countries
  }

  dimension: rownumber_top_ranking_busquedas {
    type: number
    sql: ${TABLE}.RownumberTopRankingBusquedas ;;
  }

  dimension: numero_semana_top_ranking_busquedas {
    type: number
    sql: ${TABLE}.NumeroSemanaTopRankingBusquedas ;;
  }

  dimension: usario_logeado_top5 {
    type: string
    sql: ${TABLE}.UsarioLogeadoTop5 ;;
  }

  dimension: top_producto1 {
    type: string
    sql: ${TABLE}.topProducto1 ;;
  }

  dimension: top_producto2 {
    type: string
    sql: ${TABLE}.topProducto2 ;;
  }

  dimension: top_producto3 {
    type: string
    sql: ${TABLE}.topProducto3 ;;
  }

  dimension: top_producto4 {
    type: string
    sql: ${TABLE}.topProducto4 ;;
  }

  dimension: top_producto5 {
    type: string
    sql: ${TABLE}.topProducto5 ;;
  }

  dimension: rownumber_clc {
    type: number
    sql: ${TABLE}.RownumberCLC ;;
  }

  dimension: id_cliente {
    type: string
    sql: ${TABLE}.idCliente ;;
  }

  dimension: grcliente_clc {
    type: string
    sql: ${TABLE}.GRCLienteCLC ;;
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

  dimension: omnicanal {
    type: string
    sql: ${TABLE}.omnicanal ;;
  }

  dimension: nombre_clc {
    type: string
    sql: ${TABLE}.nombreCLC ;;
  }

  dimension: apellido {
    type: string
    sql: ${TABLE}.apellido ;;
  }

  dimension: fecha_nacimiento_clc {
    type: string
    sql: ${TABLE}.fechaNacimientoCLC ;;
  }

  dimension: sexo_clc {
    type: string
    sql: ${TABLE}.sexoCLC ;;
  }

  dimension: correo_clc {
    type: string
    sql: ${TABLE}.correoCLC ;;
  }

  dimension: anio {
    type: string
    sql: ${TABLE}.anio ;;
  }

  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: hace_nsemanas {
    type: number
    sql: ${TABLE}.haceNSemanas ;;
  }

  dimension: ticke_total {
    type: number
    sql: ${TABLE}.tickeTotal ;;
  }

  dimension: conteo_compras {
    type: number
    sql: ${TABLE}.conteoCompras ;;
  }

  dimension: ticket_promedio_clc {
    type: number
    sql: ${TABLE}.TicketPromedioCLC ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  dimension: store_location {
    type: location
    sql_latitude: ${TABLE}.Latitud ;;
    sql_longitude: ${TABLE}.Longitud ;;
  }

  dimension: rownumber_top_ranking_productos {
    type: number
    sql: ${TABLE}.RownumberTopRankingProductos ;;
  }

  dimension: id_cliente_sk_top_ticket {
    type: number
    sql: ${TABLE}.IdClienteSkTopTicket ;;
  }

  dimension: sexo_top_ticke {
    type: string
    sql: ${TABLE}.sexoTopTicke ;;
  }

  dimension: edad_top_ticke {
    type: number
    sql: ${TABLE}.EdadTopTicke ;;
  }

  dimension: top_categoria1 {
    type: string
    sql: ${TABLE}.topCategoria1 ;;
  }

  dimension: top_categoria2 {
    type: string
    sql: ${TABLE}.topCategoria2 ;;
  }

  dimension: top_categoria3 {
    type: string
    sql: ${TABLE}.topCategoria3 ;;
  }

  dimension: top_categoria4 {
    type: string
    sql: ${TABLE}.topCategoria4 ;;
  }

  dimension: top_categoria5 {
    type: string
    sql: ${TABLE}.topCategoria5 ;;
  }

  dimension: numero_semana_top_ranking_productos {
    type: number
    sql: ${TABLE}.NumeroSemanaTopRankingProductos ;;
  }

  dimension: rownumber_id_cliente_recencia {
    type: number
    sql: ${TABLE}.RownumberIdClienteRecencia ;;
  }

  dimension: idclientes {
    type: number
    sql: ${TABLE}.idclientes ;;
  }

  dimension: fecha_nacimiento_soriana_recencia {
    type: string
    sql: ${TABLE}.fechaNacimientoSorianaRecencia ;;
  }

  dimension: dias_de_vida {
    type: number
    sql: ${TABLE}.diasDeVida ;;
  }

  dimension: recencia {
    type: number
    sql: ${TABLE}.recencia ;;
  }

  dimension: fecha_ultima_compra_recencia {
    type: string
    sql: ${TABLE}.fechaUltimaCompraRecencia ;;
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
      fecha_alta,
      es_empleado_soriana,
      fecha_creacion_time,
      ultima_modificacion_time,
      id_cliente_perfil_sk,
      antiguedad_cliente,
      num_saldo_puntos,
      fecha_primera_compra,
      fecha_ultima_compra,
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
      fecha_creacion_cdp_time,
      ultima_modificacion_cdp_time,
      rownumber_sesiones_ga,
      semana_sesiones_ga,
      plataforma,
      usuario_logueado,
      tipo_sesion,
      busquedas,
      compras,
      media_source,
      tiempo_engagement_min,
      estados_sesiones,
      rownumber_top_ranking_busquedas,
      numero_semana_top_ranking_busquedas,
      usario_logeado_top5,
      top_producto1,
      top_producto2,
      top_producto3,
      top_producto4,
      top_producto5,
      rownumber_clc,
      id_cliente,
      grcliente_clc,
      id_tienda,
      fecha_nacimiento_soriana,
      origen_cliente,
      omnicanal,
      nombre_clc,
      apellido,
      fecha_nacimiento_clc,
      sexo_clc,
      correo_clc,
      anio,
      semana,
      hace_nsemanas,
      ticke_total,
      conteo_compras,
      ticket_promedio_clc,
      tipo_cliente,
      store_location,
      rownumber_top_ranking_productos,
      id_cliente_sk_top_ticket,
      sexo_top_ticke,
      edad_top_ticke,
      top_categoria1,
      top_categoria2,
      top_categoria3,
      top_categoria4,
      top_categoria5,
      numero_semana_top_ranking_productos,
      rownumber_id_cliente_recencia,
      idclientes,
      fecha_nacimiento_soriana_recencia,
      dias_de_vida,
      recencia,
      fecha_ultima_compra_recencia
    ]
  }
}
