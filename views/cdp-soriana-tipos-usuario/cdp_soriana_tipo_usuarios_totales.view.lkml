view: cdp_soriana_tipo_usuarios_totales {
  derived_table: {
    sql: /**with rango_fecha as (
      select
          --format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) as fecha_inicio,
          --format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) as fecha_final),
          '20220630' as fecha_inicio,
          '20220508' as fecha_final),
          --'20220601' as fecha_final),**/

                    with rango_fecha as (
            select
            --fecha inicio
            max(format_date('%Y%m%d',FechaHoraTicket)) as  fecha_inicio,
            --semana maxima del rango
            cast( format_date('%U', parse_date("%Y%m%d",max(format_date('%Y%m%d',FechaHoraTicket)))) as INT) as max_semana,
            --fecha final 8 semanas antes, o 56 dias--- 10 semanas 70 dias
              format_date('%Y%m%d',DATE_SUB(DATE(max(FechaHoraTicket)), INTERVAL 55 DAY)) as fecha_final,
          from `costumer-data-proyect.customer_data_platform.TicketsProductivosP`),
      ------------------------------
      --------------------------------
      prep as (
      select
      distinct format_date('%Y%m%d',FechaHoraTicket) as fecha,
      IdClienteSk as clientes,
      count (distinct IdCliente) as conteoCompras,
      ImporteVentaNeta as ticket,
      from `costumer-data-proyect.customer_data_platform.TicketsProductivosP`,rango_fecha
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
      order by semana asc, idCliente asc),


      cprem as (select
      semana,
      tipoCliente,
      count(tipoCliente) as clprem
      from tipos_usuarios
      where tipoCliente ='CLIENTE PREMIUM'
      group by 1,2
      order by semana desc, tipoCliente),

      cval as (select
      semana,
      tipoCliente,
      count(tipoCliente) as clval
      from tipos_usuarios
      where tipoCliente ='CLIENTE VALIOSO'
      group by 1,2
      order by semana desc, tipoCliente),

      cpot as (select
      semana,
      tipoCliente,
      count(tipoCliente) as clpot
      from tipos_usuarios
      where tipoCliente ='CLIENTE POTENCIAL'
      group by 1,2
      order by semana desc, tipoCliente),

      cnu as (select
      semana,
      tipoCliente,
      count(tipoCliente) as clnu
      from tipos_usuarios
      where tipoCliente ='CLIENTE NUEVO'
      group by 1,2
      order by semana desc, tipoCliente),

      cnc as (select
      semana,
      tipoCliente,
      count(tipoCliente) as clnc
      from tipos_usuarios
      where tipoCliente ='NO COMPROMETIDO'
      group by 1,2
      order by semana desc, tipoCliente)

      select cp.semana,
      --cp.tipoCliente,
      cp.clprem as clientePremium,

      --cv.tipoCliente,
      cv.clval as clientevalioso,

      --cpt.tipoCliente,
      cpt.clpot as clientePotencial,

      --cn.tipoCliente,
      cn.clnu as clienteNuevo,

      --cc.tipoCliente,
      cc.clnc as clienteNoComprometido,

      cp.clprem + cv.clval + cpt.clpot + cn.clnu + cc.clnc as totalUsuarios

      from cprem as cp
      left join cval as cv on (cp.semana=cv.semana)
      left join cpot as cpt on (cp.semana=cpt.semana)
      left join cnu as cn on (cp.semana=cn.semana)
      left join cnc as cc on (cp.semana=cc.semana)
      order by cp.semana
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

  dimension: cliente_premium {
    type: number
    sql: ${TABLE}.clientePremium ;;
  }

  dimension: clientevalioso {
    type: number
    sql: ${TABLE}.clientevalioso ;;
  }

  dimension: cliente_potencial {
    type: number
    sql: ${TABLE}.clientePotencial ;;
  }

  dimension: cliente_nuevo {
    type: number
    sql: ${TABLE}.clienteNuevo ;;
  }

  dimension: cliente_no_comprometido {
    type: number
    sql: ${TABLE}.clienteNoComprometido ;;
  }

  dimension: total_usuarios {
    type: number
    sql: ${TABLE}.totalUsuarios ;;
  }

  set: detail {
    fields: [
      semana,
      cliente_premium,
      clientevalioso,
      cliente_potencial,
      cliente_nuevo,
      cliente_no_comprometido,
      total_usuarios
    ]
  }
}
