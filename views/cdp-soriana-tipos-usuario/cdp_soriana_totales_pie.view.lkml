view: cdp_soriana_totales_pie {
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
      order by idCliente asc)


      select tipoCliente,
      case
      when tipoCliente='CLIENTE PREMIUM'then count(tipoCliente)
      when tipoCliente='CLIENTE VALIOSO'then count(tipoCliente)
      when tipoCliente='CLIENTE POTENCIAL'then count(tipoCliente)
      when tipoCliente='CLIENTE NUEVO'then count(tipoCliente)
      when tipoCliente='NO COMPROMETIDO'then count(tipoCliente)
      else count(tipoCliente)
      end as Clientes,

      from tipos_usuarios
      where tipoCliente !='(NOT SET)'
      group by tipoCliente
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: percen {
    type: sum
    sql: ${TABLE}.clientes ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  dimension: clientes {
    type: number
    sql: ${TABLE}.Clientes ;;
  }

  set: detail {
    fields: [tipo_cliente, clientes]
  }
}
