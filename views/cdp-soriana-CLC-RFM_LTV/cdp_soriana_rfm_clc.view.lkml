view: cdp_soriana_rfm_clc {
  derived_table: {
    sql: select *

      from `costumer-data-proyect.calculos_rfm_clc.cdp-soriana-historico-clientes-rfm-clc-etapa5`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: countdistinct {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
  }


  measure: countdistinctPros {
    type: count_distinct
    sql: ${TABLE}.userIdGa ;;
  }

#############
  measure: clientePremium {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
    filters: [califica_cliente: "CLIENTE PREMIUM"]
  }

  measure: clienteValioso {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
    filters: [califica_cliente: "CLIENTE VALIOSO"]
  }

  measure: clientePotencial {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
    filters: [califica_cliente: "CLIENTE POTENCIAL"]
  }

  measure: clienteOcasional {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
    filters: [califica_cliente: "CLIENTE OCASIONAL"]
  }

  measure: clienteNuevo {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
    filters: [califica_cliente: "CLIENTE NUEVO"]
  }

  measure: clienteNuevo1compra {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
    filters: [califica_cliente: "CLIENTE NUEVO + 1 COMPRA"]
  }

  measure: clienteProspecto {
    type: count_distinct
    sql: ${TABLE}.userIdGa ;;
    filters: [califica_cliente: "CLIENTE PROSPECTO"]
  }

  measure: clienteDormido {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
    filters: [califica_cliente: "CLIENTE DORMIDO"]
  }

  measure: clienteEnRiesgo {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
    filters: [califica_cliente: "CLIENTE EN RIESGO"]
  }

  measure: clientePerdido {
    type: count_distinct
    sql: ${TABLE}.GRClienteId ;;
    filters: [califica_cliente: "CLIENTE PERDIDO"]
  }


##############################################
###clientes premium
  measure: gastoAcumPremium {
    type: sum
    sql: (${TABLE}.gastoPromedio8semanas) ;;
    filters: [califica_cliente: "CLIENTE PREMIUM"]
  }

###clientes valiosos
  measure: gastoAcumValioso {
    type: sum
    sql: (${TABLE}.gastoPromedio8semanas) ;;
    filters: [califica_cliente: "CLIENTE VALIOSO"]
  }


###clientes Potencial
  measure: gastoAcumPotencial {
    type: sum
    sql: (${TABLE}.gastoPromedio8semanas) ;;
    filters: [califica_cliente: "CLIENTE POTENCIAL"]
  }


###clientes ocasional
  measure: gastoAcumOcasional {
    type: sum
    sql: (${TABLE}.gastoPromedio8semanas) ;;
    filters: [califica_cliente: "CLIENTE OCASIONAL"]
  }

###clientes Nuevo
  measure: gastoAcumNuevo {
    type: sum
    sql: ${TABLE}.gastoPromedio8semanas) ;;
    filters: [califica_cliente: "CLIENTE NUEVO"]
  }


###clientes Nuevo+1 compra
  measure: gastoAcumNuevo1 {
    type: sum
    sql: (${TABLE}.gastoPromedio8semanas) ;;
    filters: [califica_cliente: "CLIENTE NUEVO + 1 COMPRA"]
  }


###clientes Dormido
  measure: gastoAcumDormido {
    type: sum
    sql: (${TABLE}.gastoPromedio8semanas) ;;
    filters: [califica_cliente: "CLIENTE DORMIDO"]
  }


###clientes En Riesgo
  measure: gastoAcumEnRiesgo {
    type: sum
    sql: (${TABLE}.gastoPromedio8semanas) ;;
    filters: [califica_cliente: "CLIENTE EN RIESGO"]
  }


###clientes En Riesgo
  measure: gastoAcumPerdido {
    type: sum
    sql: (${TABLE}.gastoPromedio8semanas) ;;
    filters: [califica_cliente: "CLIENTE PERDIDO"]
  }



#################################



######################
  dimension: grcliente_id {
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: correo {
    type: string
    sql: ${TABLE}.correo ;;
  }

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertisingId ;;
  }

  dimension: user_id_ga {
    type: string
    sql: ${TABLE}.userIdGa ;;
  }

  dimension: medio_fuente {
    type: string
    sql: ${TABLE}.medioFuente ;;
  }

  dimension: medio_fuente_origen {
    type: string
    sql: ${TABLE}.medioFuenteOrigen ;;
  }



  dimension: fecha_nacimiento_soriana {
    type: string
    sql: ${TABLE}.fechaNacimientoSoriana ;;
  }

  dimension: fecha_ultima_compra {
    type: string
    sql: ${TABLE}.fechaUltimaCompra ;;
  }

  dimension: dias_de_vida {
    type: number
    sql: ${TABLE}.diasDeVida ;;
  }

  dimension: recencia_dias {
    type: number
    sql: ${TABLE}.recenciaDias ;;
  }

  dimension: canal_exclusivo {
    type: string
    sql: ${TABLE}.canalExclusivo ;;
  }

  dimension: id_tienda {
    type: string
    sql: ${TABLE}.idTienda ;;
  }

  dimension: tienda {
    type: string
    sql: ${TABLE}.tienda ;;
  }

  dimension: formato {
    type: string
    sql: ${TABLE}.formato ;;
  }

  dimension: estado {
    type: string
    sql: ${TABLE}.estado ;;
  }

  dimension: categoria_visto1 {
    type: string
    sql: ${TABLE}.categoriaVisto1 ;;
  }

  dimension: categoria_visto2 {
    type: string
    sql: ${TABLE}.categoriaVisto2 ;;
  }

  dimension: categoria_compra1 {
    type: string
    sql: ${TABLE}.categoriaCompra1 ;;
  }

  dimension: categoria_compra2 {
    type: string
    sql: ${TABLE}.categoriaCompra2 ;;
  }

  dimension: categoria_compra3 {
    type: string
    sql: ${TABLE}.categoriaCompra3 ;;
  }

  dimension: compras_de_la_semana {
    type: number
    sql: ${TABLE}.comprasDeLaSemana ;;
  }

  dimension: gasto_de_la_semana {
    type: number
    sql: ${TABLE}.gastoDeLaSemana ;;
  }

  dimension: anio {
    type: string
    sql: ${TABLE}.anio ;;
  }

  dimension: semanas_cliente {
    type: number
    sql: ${TABLE}.semanasCliente ;;
  }

  dimension: hace_nsemanas {
    type: number
    sql: ${TABLE}.haceNSemanas ;;
  }

  dimension: conteo_compras8_semanas {
    type: number
    sql: ${TABLE}.conteoCompras8Semanas ;;
  }

  dimension: dias_sin_compra {
    type: number
    sql: ${TABLE}.diasSinCompra ;;
  }

  dimension: gasto_promedio8semanas {
    type: number
    sql: ${TABLE}.gastoPromedio8semanas ;;
  }

  dimension: frecuencia_en_dias {
    type: number
    sql: ${TABLE}.frecuenciaEnDias ;;
  }

  dimension: califica_cliente {
    type: string
    sql: ${TABLE}.calificaCliente ;;
  }


  measure: sumaGatoSemana{
    type: sum
    sql: ${TABLE}.gastoDeLaSemana ;;
  }

  measure: sumaCompraSemana{
    type: sum
    sql: ${TABLE}.comprasDeLaSemana ;;
  }

  measure: sumaGastoAcumulado{
    type: sum
    sql: ${TABLE}.gastoPromedio8semanas ;;
  }


  set: detail {
    fields: [
      grcliente_id,
      advertising_id,
      user_id_ga,
      correo,
      medio_fuente,
      medio_fuente_origen,
      fecha_nacimiento_soriana,
      fecha_ultima_compra,
      dias_de_vida,
      recencia_dias,
      canal_exclusivo,
      id_tienda,
      tienda,
      formato,
      estado,
      categoria_visto1,
      categoria_visto2,
      categoria_compra1,
      categoria_compra2,
      categoria_compra3,
      compras_de_la_semana,
      gasto_de_la_semana,
      anio,
      semanas_cliente,
      hace_nsemanas,
      conteo_compras8_semanas,
      dias_sin_compra,
      gasto_promedio8semanas,
      frecuencia_en_dias,
      califica_cliente
    ]
  }
}
