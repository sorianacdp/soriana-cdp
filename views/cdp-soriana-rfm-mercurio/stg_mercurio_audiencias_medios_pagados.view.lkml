view: stg_mercurio_audiencias_medios_pagados {
  sql_table_name: `costumer-data-proyect.STG_data.STG_mercurio_audiencias_medios_pagados`
    ;;

  dimension: advertising_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.AdvertisingId ;;
  }

  dimension: audiencia {
    type: string
    sql: ${TABLE}.Audiencia ;;
  }

  dimension: correo {
    type: string
    sql: ${TABLE}.Correo ;;
  }

  dimension: nombre {
    type: string
    sql: ${TABLE}.Nombre ;;
  }

  dimension: telefono_celular {
    type: string
    sql: ${TABLE}.TelefonoCelular ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
