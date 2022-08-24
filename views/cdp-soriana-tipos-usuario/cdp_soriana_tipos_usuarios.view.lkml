view: cdp_soriana_tipos_usuarios {
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
              format_date('%Y%m%d',DATE_SUB(DATE(max(FechaHoraTicket)), INTERVAL 90 DAY)) as fecha_final,
          from `costumer-data-proyect.customer_data_platform.TicketsProductivosP`),
      ------------------------------
      --------------------------------
        prep as (
  select
  distinct format_date('%Y%m%d',FechaHoraTicket) as fecha,
  IdClienteSk as clientes,
  count (distinct IdClienteSk) as conteoCompras,
  ImporteVentaNeta as ticket,
  from `costumer-data-proyect.customer_data_platform.TicketsProductivosP`,rango_fecha
  where  format_date('%Y%m%d',FechaHoraTicket) <= rango_fecha.fecha_inicio and  format_date('%Y%m%d',FechaHoraTicket) >=rango_fecha.fecha_final and IdClienteSk is not null
  group by 1,2,4
  )

      select
      --info cliente
       distinct cast(clientes as STRING) as idCliente,
      cp.GRClienteId as GRClienteId,
      cp.nombre as nombre,
      cp.apellidoPaterno as apellido,
      format_date('%Y-%m-%d',cp.fechaNacimiento) as fechaNacimiento,
      cp.sexo as sexo,
      cp.correo as correo,

      --info compras
      format_date('%U', parse_date("%Y%m%d",fecha)) as semana,
      sum(ticket) as tickeTotal,
      sum(conteoCompras) as conteoCompras,
      sum(ticket)/sum(conteoCompras) as ticketPromedio,
      --tipo de cliente
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
      left join `costumer-data-proyect.customer_data_platform.cdp_synapse_clientes_productivos` as cp on (clientes=cp.IdClienteSk)
      --where cp.correo is not null
      group by 1,2,3,4,5,6,7,8
      order by semana asc, idCliente asc
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

  dimension: grIdCliente {
    type: string
    sql: ${TABLE}.GRClienteId ;;
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

  dimension: ticket_promedio {
    type: number
    sql: ${TABLE}.ticketPromedio ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  set: detail {
    fields: [
      id_cliente,
      grIdCliente,
      nombre,
      apellido,
      fecha_nacimiento,
      sexo,
      correo,
      semana,
      ticke_total,
      conteo_compras,
      ticket_promedio,
      tipo_cliente
    ]
  }
}
