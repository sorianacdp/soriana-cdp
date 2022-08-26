view: cdp_synapse_clientes_productivos {
  sql_table_name: `costumer-data-proyect.customer_data_platform.cdp_synapse_clientes_productivos`
    ;;

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
  }

  dimension: antiguedad_cliente {
    type: number
    sql: ${TABLE}.antiguedadCliente ;;
  }

  dimension: apellido_materno {
    type: string
    sql: ${TABLE}.apellidoMaterno ;;
  }

  dimension: apellido_paterno {
    type: string
    sql: ${TABLE}.apellidoPaterno ;;
  }

  dimension: calle {
    type: string
    sql: ${TABLE}.calle ;;
  }

  dimension: codigo_postal {
    type: number
    sql: ${TABLE}.codigoPostal ;;
  }

  dimension: coindicencia_sfccclientes_sfccinvitados {
    type: number
    sql: ${TABLE}.coindicenciaSFCCClientesSFCCInvitados ;;
  }

  dimension: colonia {
    type: string
    sql: ${TABLE}.colonia ;;
  }

  dimension: compra_mayor {
    type: number
    sql: ${TABLE}.compraMayor ;;
  }

  dimension: correo {
    type: string
    sql: ${TABLE}.correo ;;
  }

  dimension: cuenta_bancaria {
    type: string
    sql: ${TABLE}.cuentaBancaria ;;
  }

  dimension: es_empleado_soriana {
    type: yesno
    sql: ${TABLE}.esEmpleadoSoriana ;;
  }

  dimension: estado {
    type: string
    sql: ${TABLE}.estado ;;
  }

  dimension_group: fecha_alta {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.fechaAlta ;;
  }

  dimension_group: fecha_creacion {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.fechaCreacion ;;
  }

  dimension_group: fecha_creacion_cdp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.FechaCreacionCDP ;;
  }

  dimension_group: fecha_nacimiento {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.fechaNacimiento ;;
  }

  dimension_group: fecha_primera_compra {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.fechaPrimeraCompra ;;
  }

  dimension_group: fecha_ultima_compra {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.fechaUltimaCompra ;;
  }

  dimension: gauser_id {
    type: string
    sql: ${TABLE}.GAUserId ;;
  }

  dimension: grcliente_id {
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: id_cliente_city_web {
    type: string
    sql: ${TABLE}.idClienteCityWeb ;;
  }

  dimension: id_cliente_digital {
    type: number
    sql: ${TABLE}.idClienteDigital ;;
  }

  dimension: id_cliente_membresias {
    type: string
    sql: ${TABLE}.idClienteMembresias ;;
  }

  dimension: id_cliente_perfil_sk {
    type: number
    sql: ${TABLE}.idClientePerfilSk ;;
  }

  dimension: id_cliente_prog_recompensas {
    type: number
    sql: ${TABLE}.idClienteProgRecompensas ;;
  }

  dimension: id_cliente_setc {
    type: string
    sql: ${TABLE}.idClienteSETC ;;
  }

  dimension: id_cliente_sfcc {
    type: string
    sql: ${TABLE}.idClienteSFCC ;;
  }

  dimension: id_cliente_sk {
    type: number
    sql: ${TABLE}.idClienteSk ;;
  }

  dimension: id_cliente_sorianacom {
    type: string
    sql: ${TABLE}.idClienteSorianacom ;;
  }

  dimension: is_insertsfmc {
    type: string
    sql: ${TABLE}.isInsertsfmc ;;
  }

  dimension: nombre {
    type: string
    sql: ${TABLE}.nombre ;;
  }

  dimension: num_saldo_puntos {
    type: number
    sql: ${TABLE}.numSaldoPuntos ;;
  }

  dimension: num_visitas {
    type: number
    sql: ${TABLE}.numVisitas ;;
  }

  dimension: origen {
    type: string
    sql: ${TABLE}.origen ;;
  }

  dimension: poblacion {
    type: string
    sql: ${TABLE}.poblacion ;;
  }

  dimension: sexo {
    type: string
    sql: ${TABLE}.sexo ;;
  }

  dimension: sfcustomer_no {
    type: string
    sql: ${TABLE}.SFCustomerNo ;;
  }

  dimension: telefono_celular {
    type: number
    sql: ${TABLE}.telefonoCelular ;;
  }

  dimension: telefono_particular {
    type: string
    sql: ${TABLE}.telefonoParticular ;;
  }

  dimension: ticket_promedio {
    type: number
    sql: ${TABLE}.ticketPromedio ;;
  }

  dimension_group: ultima_modificacion {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.ultimaModificacion ;;
  }

  dimension: ultima_modificacion_cdp {
    type: string
    sql: ${TABLE}.UltimaModificacionCDP ;;
  }

  dimension: validacion_apellido_materno {
    type: number
    sql: ${TABLE}.validacionApellidoMaterno ;;
  }

  dimension: validacion_apellido_paterno {
    type: number
    sql: ${TABLE}.validacionApellidoPaterno ;;
  }

  dimension: validacion_codigo_postal {
    type: number
    sql: ${TABLE}.validacionCodigoPostal ;;
  }

  dimension: validacion_correo {
    type: number
    sql: ${TABLE}.validacionCorreo ;;
  }

  dimension: validacion_duplicados {
    type: number
    sql: ${TABLE}.validacionDuplicados ;;
  }

  dimension: validacion_estado {
    type: number
    sql: ${TABLE}.validacionEstado ;;
  }

  dimension: validacion_fecha_nacimiento {
    type: number
    sql: ${TABLE}.validacionFechaNacimiento ;;
  }

  dimension: validacion_nombre {
    type: number
    sql: ${TABLE}.validacionNombre ;;
  }

  dimension: validacion_sexo {
    type: number
    sql: ${TABLE}.validacionSexo ;;
  }

  dimension: validacion_telefono_celular {
    type: number
    sql: ${TABLE}.validacionTelefonoCelular ;;
  }

  dimension: validacion_telefono_fijo {
    type: number
    sql: ${TABLE}.validacionTelefonoFijo ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
