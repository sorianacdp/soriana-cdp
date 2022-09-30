view: cdpsorianaticketsgaropo {
  sql_table_name: `costumer-data-proyect.customer_data_platform.cdp-soriana-tickets-ga-ropo`
    ;;

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
  }

  dimension: anio_busqueda {
    type: number
    sql: ${TABLE}.AnioBusqueda ;;
  }

  dimension: articulos_vistos {
    type: string
    sql: ${TABLE}.articulosVistos ;;
  }

  dimension: categoria_articulo {
    type: string
    sql: ${TABLE}.categoriaArticulo ;;
  }

  dimension: correo {
    type: string
    sql: ${TABLE}.correo ;;
  }

  dimension_group: fecha {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.fecha ;;
  }

  dimension_group: fecha_ticket {
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
    sql: ${TABLE}.fechaTicket ;;
  }

  dimension: fuente_medio_usuario {
    type: string
    sql: ${TABLE}.fuenteMedioUsuario ;;
  }

  dimension: gauser_id {
    type: string
    sql: ${TABLE}.GAUserId ;;
  }

  dimension: grcliente_id {
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: id_articulo {
    type: string
    sql: ${TABLE}.idArticulo ;;
  }

  dimension: id_cliente_sk {
    type: number
    sql: ${TABLE}.idClienteSk ;;
  }

  dimension: id_sesion {
    type: number
    sql: ${TABLE}.idSesion ;;
  }

  dimension: id_ticket_sk {
    type: number
    sql: ${TABLE}.IdTicketSk ;;
  }

  dimension: id_tienda {
    type: string
    sql: ${TABLE}.IdTienda ;;
  }

  dimension: marca_articulo {
    type: string
    sql: ${TABLE}.marcaArticulo ;;
  }

  dimension: nombre_campana {
    type: string
    sql: ${TABLE}.nombreCampana ;;
  }

  dimension: plataforma {
    type: string
    sql: ${TABLE}.plataforma ;;
  }

  dimension: precio {
    type: number
    sql: ${TABLE}.precio ;;
  }


  dimension: semana_busqueda {
    type: number
    sql: ${TABLE}.semanaBusqueda ;;
  }

  dimension: semana_compra {
    type: number
    sql: ${TABLE}.SemanaCompra ;;
  }

  dimension: sfcustomer_no {
    type: string
    sql: ${TABLE}.SFCustomerNo ;;
  }

  dimension: variante_articulo {
    type: string
    sql: ${TABLE}.varianteArticulo ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
