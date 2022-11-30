view: semanavistayropo {
  derived_table: {
    sql: WITH  dataset1 as (
      SELECT Extract(week from po.fecha) semana, count(1) cantidadROPO From  `customer_data_platform.cdp-soriana-tickets-ga-ropo` po
      group by 1
), dataset2 as (
      SELECT Extract(week from ro.fecha) semana, count(1) cantidadVistas From `customer_data_platform.cdp-usuario-articulos-vistos-sin-compra-ropo` ro
      GROUP BY 1
)
select
      Extract(week from current_date) - d1.semana as haceNSemana,
      --d1.fecha,
      d1.cantidadROPO,
      d2.cantidadVistas
      From dataset1 d1, dataset2 d2 where d1.semana = d2.semana
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hace_nsemana {
    type: number
    sql: ${TABLE}.haceNSemana ;;
  }

  dimension: cantidad_ropo {
    type: number
    sql: ${TABLE}.cantidadROPO ;;
  }

  dimension: cantidad_vistas {
    type: number
    sql: ${TABLE}.cantidadVistas ;;
  }

  set: detail {
    fields: [hace_nsemana, cantidad_ropo, cantidad_vistas]
  }
}
