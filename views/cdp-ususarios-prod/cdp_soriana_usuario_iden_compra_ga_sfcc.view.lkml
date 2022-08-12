view: cdp_soriana_usuario_iden_compra_ga_sfcc {
  derived_table: {
    sql: select fecha, usuarioLogueado, email,firstName,fatherName,phoneMobile,nombreCampana , idTransaccion, idArticulo, articulosComprados, precioVenta, cantidad, precioUnitario

      from `costumer-data-proyect.customer_data_platform.cdp-usuario_ articulos _ga_gads_fads_purchase`
      left join `costumer-data-proyect.salesforce_commerce_cloud.stg_CustomerSalesforce`  as sfcc on (usuarioLogueado=sfcc.customerId)

      where usuarioLogueado != '(not set)' and idTransaccion != '(not set)' and email is not null

      order by fecha desc
      --limit 1000
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: fecha {
    type: date
    datatype: date
    sql: ${TABLE}.fecha ;;
  }

  dimension: usuario_logueado {
    type: string
    sql: ${TABLE}.usuarioLogueado ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.firstName ;;
  }

  dimension: father_name {
    type: string
    sql: ${TABLE}.fatherName ;;
  }

  dimension: phone_mobile {
    type: string
    sql: ${TABLE}.phoneMobile ;;
  }

  dimension: nombre_campana {
    type: string
    sql: ${TABLE}.nombreCampana ;;
  }

  dimension: id_transaccion {
    type: string
    sql: ${TABLE}.idTransaccion ;;
  }

  dimension: id_articulo {
    type: string
    sql: ${TABLE}.idArticulo ;;
  }

  dimension: articulos_comprados {
    type: string
    sql: ${TABLE}.articulosComprados ;;
  }

  dimension: precio_venta {
    type: number
    sql: ${TABLE}.precioVenta ;;
  }

  dimension: cantidad {
    type: number
    sql: ${TABLE}.cantidad ;;
  }

  dimension: precio_unitario {
    type: number
    sql: ${TABLE}.precioUnitario ;;
  }

  set: detail {
    fields: [
      fecha,
      usuario_logueado,
      email,
      first_name,
      father_name,
      phone_mobile,
      nombre_campana,
      id_transaccion,
      id_articulo,
      articulos_comprados,
      precio_venta,
      cantidad,
      precio_unitario
    ]
  }
}
