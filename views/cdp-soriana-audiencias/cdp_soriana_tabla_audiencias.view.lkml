view: cdp_soriana_tabla_audiencias {
  derived_table: {
    sql: select *
      from `costumer-data-proyect.customer_data_platform.cdp-soriana-tablero-generacion-audiencias`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: grcliente_id {
    type: string
    sql: ${TABLE}.GRClienteId ;;
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

  dimension: frecuencia_en_dias {
    type: number
    sql: ${TABLE}.frecuenciaEnDias ;;
  }

  dimension: califica_cliente {
    type: string
    sql: ${TABLE}.calificaCliente ;;
  }

  set: detail {
    fields: [
      grcliente_id,
      advertising_id,
      user_id_ga,
      medio_fuente,
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
      frecuencia_en_dias,
      califica_cliente
    ]
  }
}
