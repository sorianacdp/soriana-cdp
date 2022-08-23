view: cdp_soriana_tipo_usuario_ultima_compra_recuperable {
  derived_table: {
    sql: with rango_fecha as (
        select
        --fecha inicio
        max(format_date('%Y%m%d',FechaHoraTicket)) as  fecha_inicio,
        --semana maxima del rango
        cast( format_date('%U', parse_date("%Y%m%d",max(format_date('%Y%m%d',FechaHoraTicket)))) as INT) as max_semana,
        --fecha final 8 semanas antes, o 56 dias--- 10 semanas 70 dias
          format_date('%Y%m%d',DATE_SUB(DATE(max(FechaHoraTicket)), INTERVAL 90 DAY)) as fecha_final,
      from `costumer-data-proyect.customer_data_platform.TicketsProductivos`),
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

      ultimaCompraCliente as (
      select
      distinct clientes,
      max_semana,
      cast( format_date('%U', parse_date("%Y%m%d",max(fecha))) as INT) as semanaUltimaCompra
      from prep,rango_fecha
      group by 1,2
      order by semanaUltimaCompra),


      ulti_comp as (select
      --Info Clientes:
      distinct clientes as idCliente,
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
      group by 1,2,3,4,5,6,7,8
      order by clientes asc)

      select
      count(distinct idCliente) as clientes,
      tipoCliente,
      semanaUltimaCompra
      from ulti_comp
      where tipoCliente='CLIENTE RECUPERABLE'
      group by 2,3
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: clientes {
    type: number
    sql: ${TABLE}.clientes ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  dimension: semana_ultima_compra {
    type: number
    sql: ${TABLE}.semanaUltimaCompra ;;
  }

  set: detail {
    fields: [clientes, tipo_cliente, semana_ultima_compra]
  }
}
