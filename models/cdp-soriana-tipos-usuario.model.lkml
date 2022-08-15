connection: "cdp-soriana-dataset-prod"

include: "/views/cdp-soriana-tipos-usuario/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }


explore: cdp_soriana_tipos_usuarios {}
explore: cdp_soriana_tipo_cliente_premium {}
explore: cdp_soriana_tipo_cliente_valioso {}
explore: cdp_soriana_tipo_cliente_potencial {}
explore: cdp_soriana_tipo_cliente_nuevo {}
explore: cdp_soriana_tipo_cliente_no_comprometido {}
explore: cdp_soriana_tipo_usuarios_totales {}
explore: cdp_soriana_totales_pie {}
explore: cdp_soriana_tipos_usuario_ultima_compra {}
explore: cdp_soriana_tipo_usuario_ultima_compra_totales {}
explore: cdp_soriana_tipo_usuario_ultima_compra_actual {}
explore: cdp_soriana_tipo_usuario_ultima_compra_recuperable {}
explore: cdp_soriana_tipo_usuario_ultima_compra_no_regresa {}
