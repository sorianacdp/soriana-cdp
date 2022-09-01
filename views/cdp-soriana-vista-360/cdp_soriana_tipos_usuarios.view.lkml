view: cdp_soriana_tipos_usuarios {
  derived_table: {
    sql: with rango_fecha as (
            select
            --fecha inicio
            max(format_date('%Y%m%d',FechaHoraTicket)) as  fecha_inicio,
            --semana maxima del rango
            cast( format_date('%U', parse_date("%Y%m%d",max(format_date('%Y%m%d',FechaHoraTicket)))) as INT) as max_semana,
            --fecha final 8 semanas antes, o 56 dias--- 10 semanas 70 dias
              format_date('%Y%m%d',DATE_SUB(DATE(max(FechaHoraTicket)), INTERVAL 90 DAY)) as fecha_final,
          from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`),
      ------------------------------
      --------------------------------
        prep as (
  select
  distinct format_date('%Y%m%d',FechaHoraTicket) as fecha,

      IdClienteSk as clientes,
      IdTienda as tienda,
      count (distinct IdClienteSk) as conteoCompras,
      ImporteVentaNeta as ticket
      from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`,rango_fecha
      where  format_date('%Y%m%d',FechaHoraTicket) <= rango_fecha.fecha_inicio and  format_date('%Y%m%d',FechaHoraTicket) >=rango_fecha.fecha_final and IdClienteSk is not null
      group by 1,2,3,5
      ),nacimientoSoriana as (
      select
      distinct IdClienteSk as idclientes,
      DATE_DIFF(CURRENT_DATE(), parse_date("%Y%m%d",min(format_date('%Y%m%d',FechaHoraTicket))), DAY)  as diasDeVida,
      min(format_date('%Y-%m-%d',FechaHoraTicket)) as fechaNacimientoSoriana,

      from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`
      where  format_date('%Y%m%d',FechaHoraTicket) between '20210101' and format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) and IdClienteSk is not null
      group by 1
      ),

      ----------------------------
      ----------------------------
      ----canal del cliente
      ventaTienda as (
      SELECT
      distinct IdClienteSk as IdClienteSkvt,
      'OFFLINE' as canalCliente
      FROM `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`
      where EsVentaInternet = false and IdCanal= 7 ),

      ventaInternet as (
      SELECT
      distinct IdClienteSk as IdClienteSkvi,
      'ONLINE' as canalCliente
      FROM `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`
      where EsVentaInternet= true and IdCanal= 3 ),

      omni as (select
      distinct vt.IdClienteSkvt as clienteOmni,
      'OMNICANAL' as canalCliente
      from ventaTienda as vt
      inner join ventaInternet as vi on (vt.IdClienteSkvt = vi.IdClienteSkvi)),

      restavenTienda as (select
      vt.IdClienteSkvt as id, vt.canalCliente as canalCliente
      from ventaTienda as vt
      left join omni as om on (vt.IdClienteSkvt=om.clienteOmni)
      where om.clienteOmni is null),

      restavenInternet as (select
      vi.IdClienteSkvi as id, vi.canalCliente as canalCliente
      from ventaInternet as vi
      left join omni as om on (vi.IdClienteSkvi=om.clienteOmni)
      where om.clienteOmni is null),

      canaltotal as (
      select clienteOmni,canalCliente from omni
      union distinct
      select * from restavenTienda
      union distinct
      select * from restavenInternet
      order by clienteOmni)
      ---------------------------------------
      --------------------------------------
      ---------------------------
      select
      --info cliente
      distinct cast(p.clientes as STRING) as idCliente,
      cp.GRClienteId as GR_Cliente_Id,
      p.tienda as idTienda,
      ns.fechaNacimientoSoriana,
      ct.canalCliente as origenCliente,
      --info compras
      format_date('%U', parse_date("%Y%m%d",fecha)) as semana,
      sum(p.ticket) as tickeTotal,
      sum(p.conteoCompras) as conteoCompras,
      sum(p.ticket)/sum(p.conteoCompras) as ticketPromedioCliente,
      td.Latitud,
      td.Longitud,
      --tipo de cliente
      --tipo de cliente
      case
      when (sum(p.conteoCompras)>= 4) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'CLIENTE PREMIUM'
      when (sum(p.conteoCompras)>= 2 and sum(p.conteoCompras)<= 3) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'CLIENTE VALIOSO'
      when (sum(p.conteoCompras)>= 1 and sum(p.conteoCompras)<= 2) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'CLIENTE POTENCIAL'
      when (sum(p.conteoCompras)= 1) then 'CLIENTE NUEVO'
      when (sum(p.conteoCompras)= 0) then 'CLIENTE PROSPECTO'
      when (sum(p.conteoCompras)>= 4) and (sum(p.ticket)/sum(p.conteoCompras) >= 150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'CLIENTE VALIOSO'
      when (sum(p.conteoCompras)>= 2 and sum(p.conteoCompras)<= 3) and (sum(p.ticket)/sum(p.conteoCompras) >=150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'CLIENTE POTENCIAL'
      when (sum(p.conteoCompras)>= 1 and sum(p.conteoCompras)<= 2) and (sum(p.ticket)/sum(p.conteoCompras) >= 150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'NO COMPROMETIDO'
      when (sum(p.conteoCompras)>= 4) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'CLIENTE POTENCIAL'
      when (sum(p.conteoCompras)>= 1 and sum(p.conteoCompras)<= 3) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'NO COMPROMETIDO'
      when (sum(p.conteoCompras)>= 2 and sum(p.conteoCompras)<= 3) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'NO COMPROMETIDO'
      when (sum(p.conteoCompras)>= 1 and sum(p.conteoCompras)<= 2) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'NO COMPROMETIDO'
      when (sum(p.conteoCompras)>= 1 and sum(p.conteoCompras)<= 2) and (sum(p.ticket)/sum(p.conteoCompras) >= 150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'NO COMPROMETIDO'
      when (sum(p.conteoCompras)>= 1 and sum(p.conteoCompras)<= 3) and (sum(p.ticket)/sum(p.conteoCompras) >= 150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'NO COMPROMETIDO'
      when (sum(p.conteoCompras)>= 1 and sum(p.conteoCompras)<= 3) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'NO COMPROMETIDO'
      else '(not set )'
      end as tipoCliente

      from prep as p
      left join `costumer-data-proyect.customer_data_platform.cdp_synapse_clientes_productivos` as cp on (p.clientes=cp.IdClienteSk)
      left join nacimientoSoriana as ns on ( p.clientes= ns.idclientes)
      left join canaltotal as ct on ( p.clientes=ct.clienteOmni)
      inner join `costumer-data-proyect.customer_data_platform.cdp_synapse_tiendas_productivas` as td on (td.IdTienda = p.tienda)
      group by 1,2,3,4,5,6, td.Latitud,td.Longitud
      order by semana asc, idCliente desc
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

  dimension: gr_cliente_id {
    type: string
    sql: ${TABLE}.GR_Cliente_Id ;;
  }

  dimension: id_tienda {
    type: string
    sql: ${TABLE}.idTienda ;;
  }

  dimension: fecha_nacimiento_soriana {
    type: string
    sql: ${TABLE}.fechaNacimientoSoriana ;;
  }

  dimension: origen_cliente {
    type: string
    sql: ${TABLE}.origenCliente ;;
  }

  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: ticke_total {
    type: number
    sql: ${TABLE}.tickeTotal ;;
  }

  dimension: conteo_compras {
    type: number
    sql: ${TABLE}.conteoCompras ;;
  }

  dimension: ticket_promedio_cliente {
    type: number
    sql: ${TABLE}.ticketPromedioCliente ;;
  }

  dimension: latitud {
    type: number
    sql: ${TABLE}.Latitud ;;
  }

  dimension: longitud {
    type: number
    sql: ${TABLE}.Longitud ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  set: detail {
    fields: [
      id_cliente,
      gr_cliente_id,
      id_tienda,
      fecha_nacimiento_soriana,
      origen_cliente,
      semana,
      ticke_total,
      conteo_compras,
      ticket_promedio_cliente,
      latitud,
      longitud,
      tipo_cliente
    ]
  }
}
