connection: "cdp-soriana-dataset-prod"

include: "/views/cdp-soriana-roi-ropo/*.view.lkml"                # include all views in the views/ folder in this project
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
explore: cdpusuario__articulos__ga_gads_fads_add_cart {}
explore: cdpusuario__articulos__ga_gads_fads_purchase {}
explore: cdpusuario__articulos__ga_gads_fads_view_item {}
explore: facebookads {}
explore: googleads {}
explore: cdpsorianaticketsgaropo {}
explore: semanavistayropo {}
explore: googleadsingresosvscostos {}
explore: facebookadsingresovscosto {}
