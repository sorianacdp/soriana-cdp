view: cdp_soriana_tipos_usuario_ultima_compra {
  derived_table: {
    sql: with rango_fecha as (
        select
        --fecha inicio
        max(format_date('%Y%m%d',FechaHoraTicket)) as  fecha_inicio,
        --semana maxima del rango
        cast( format_date('%U', parse_date("%Y%m%d",max(format_date('%Y%m%d',FechaHoraTicket)))) as INT) as max_semana,
        --fecha final 8 semanas antes, o 56 dias--- 10 semanas 70 dias
          format_date('%Y%m%d',DATE_SUB(DATE(max(FechaHoraTicket)), INTERVAL 90 DAY)) as fecha_final,
      from `costumer-data-proyect.customer_data_platform.TicketsProductivosP`),
      ------------------------------
      --------------------------------
      prep as (
      select
      distinct format_date('%Y%m%d',FechaHoraTicket) as fecha,
      IdClienteSk as clientes,
      IdTienda as tienda,
      count (distinct IdClienteSk) as conteoCompras,
      ImporteVentaNeta as ticket,
      from `costumer-data-proyect.customer_data_platform.TicketsProductivosP`,rango_fecha
      where  format_date('%Y%m%d',FechaHoraTicket) <= rango_fecha.fecha_inicio and  format_date('%Y%m%d',FechaHoraTicket) >=rango_fecha.fecha_final and IdClienteSk is not null
      group by 1,2,3,5
      ),

      ultimaCompraCliente as (
      select
      distinct clientes,
      max_semana,
      tienda,
      cast( format_date('%U', parse_date("%Y%m%d",max(fecha))) as INT) as semanaUltimaCompra
      from prep,rango_fecha
      group by 1,2,3
      order by semanaUltimaCompra)


      select
      --Info Clientes:
      distinct cast(clientes as string) as idCliente,
      cp.GRClienteId as GRClienteId,
      uc.tienda as idTienda,
      cp.nombre as nombre,
      cp.apellidoPaterno as apellido,
      format_date('%Y-%m-%d',cp.fechaNacimiento) as fechaNacimiento,
      cp.sexo as sexo,
      cp.correo as correo,
      semanaUltimaCompra,
      --tipos se clientes
      case
      when (semanaUltimaCompra >= max_semana-7) and (semanaUltimaCompra <= max_semana-6) then 'CLIENTE RECUPERABLE'
      when (semanaUltimaCompra <= max_semana-8) then 'CLIENTE NO REGRESA'
      when (semanaUltimaCompra > max_semana-6) then 'CLIENTE ACTUAL'
      end as tipoCliente

      from ultimaCompraCliente as uc
      left join `costumer-data-proyect.customer_data_platform.cdp_synapse_clientes_productivos` as cp on (uc.clientes=cp.IdClienteSk)
      --where cp.correo is not null
      group by 1,2,3,4,5,6,7,8,9,10
      order by semanaUltimaCompra desc
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_cliente {
    type: string
    sql: ${TABLE}.idCliente ;;
  }

  dimension: GRClienteId {
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: idTienda {
    type: string
    sql: ${TABLE}.idTienda ;;
  }

  dimension: nombre {
    type: string
    sql: ${TABLE}.nombre ;;
  }

  dimension: apellido {
    type: string
    sql: ${TABLE}.apellido ;;
  }

  dimension: fecha_nacimiento {
    type: string
    sql: ${TABLE}.fechaNacimiento ;;
  }

  dimension: sexo {
    type: string
    sql: ${TABLE}.sexo ;;
  }

  dimension: correo {
    type: string
    sql: ${TABLE}.correo ;;
  }

  dimension: semana_ultima_compra {
    type: number
    sql: ${TABLE}.semanaUltimaCompra ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  set: detail {
    fields: [
      id_cliente,
      GRClienteId,
      idTienda,
      nombre,
      apellido,
      fecha_nacimiento,
      sexo,
      correo,
      semana_ultima_compra,
      tipo_cliente
    ]
  }
}
