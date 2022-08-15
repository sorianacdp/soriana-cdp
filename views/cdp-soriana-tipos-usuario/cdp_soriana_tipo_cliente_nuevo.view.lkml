view: cdp_soriana_tipo_cliente_nuevo {
  derived_table: {
    sql: with rango_fecha as (
      select
          --format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) as fecha_inicio,
          --format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) as fecha_final),
          '20220630' as fecha_inicio,
          '20220508' as fecha_final),
          --'20220601' as fecha_final),
      ------------------------------
      --------------------------------
      prep as (
      select
      distinct format_date('%Y%m%d',FechaHoraTicket) as fecha,
      IdClienteSk as clientes,
      count (distinct IdCliente) as conteoCompras,
      ImporteVentaNeta as ticket,
      from `costumer-data-proyect.customer_data_platform.TicketsProductivos`,rango_fecha
      where  format_date('%Y%m%d',FechaHoraTicket) <= rango_fecha.fecha_inicio and  format_date('%Y%m%d',FechaHoraTicket) >=rango_fecha.fecha_final and IdCliente is not null
      group by 1,2,4
      ),

      tipos_usuarios as (select
      distinct format_date('%U', parse_date("%Y%m%d",fecha)) as semana,
      cast(clientes as STRING) as idCliente,
      sum(ticket) as tickeTotal,
      sum(conteoCompras) as conteoCompras,
      sum(ticket)/sum(conteoCompras) as ticketPromedio,
      case
      when (sum(conteoCompras)>= 4) and (sum(ticket)/sum(conteoCompras) > 570) then 'CLIENTE PREMIUM'
      when (sum(conteoCompras)>= 2 and sum(conteoCompras)<= 3) and (sum(ticket)/sum(conteoCompras) > 570) then 'CLIENTE VALIOSO'
      when (sum(conteoCompras)>= 1 and sum(conteoCompras)<= 2) and (sum(ticket)/sum(conteoCompras) > 570) then 'CLIENTE POTENCIAL'
      when (sum(conteoCompras)= 1) then 'CLIENTE NUEVO'
      when (sum(conteoCompras)= 0) then 'CLIENTE PROSPECTO'
      when (sum(conteoCompras)>= 4) and (sum(ticket)/sum(conteoCompras) > 150 and sum(ticket)/sum(conteoCompras) < 570) then 'CLIENTE VALIOSO'
      when (sum(conteoCompras)>= 2 and sum(conteoCompras)<= 3) and (sum(ticket)/sum(conteoCompras) > 150 and sum(ticket)/sum(conteoCompras) < 570) then 'CLIENTE POTENCIAL'
      when (sum(conteoCompras)>= 1 and sum(conteoCompras)<= 2) and (sum(ticket)/sum(conteoCompras) > 150 and sum(ticket)/sum(conteoCompras) < 570) then 'NO COMPROMETIDO'
      when (sum(conteoCompras)>= 4) and (sum(ticket)/sum(conteoCompras) < 150) then 'CLIENTE POTENCIAL'
      when (sum(conteoCompras)>= 1 and sum(conteoCompras)<= 3) and (sum(ticket)/sum(conteoCompras) < 150) then 'NO COMPROMETIDO'
      else '(NOT SET)'
      end as tipoCliente
      from prep
      group by semana,clientes
      order by semana asc, idCliente asc )

      select semana,tipoCliente, count(tipoCliente) as cantidadDeClientes
      from tipos_usuarios
      where tipoCliente ='CLIENTE NUEVO'
      group by 1,2
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  dimension: cantidad_de_clientes {
    type: number
    sql: ${TABLE}.cantidadDeClientes ;;
  }

  set: detail {
    fields: [semana, tipo_cliente, cantidad_de_clientes]
  }
}
