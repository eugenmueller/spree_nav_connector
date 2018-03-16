class CreateSpreeNavisionItems < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_navision_items do |t|
      t.string :key
      t.string :rec_id
      t.string :no
      t.string :description
      t.string :description_2
      t.string :long_text
      t.string :base_unit_of_measure
      t.string :item_category_code
      t.string :product_group_code
      t.string :group_of_goods_code
      t.string :vat_bus_posting_gr_price
      t.string :vat_prod_posting_group
      t.boolean :blocked
      t.string :eol
      t.string :manufacturer_item_no_1
      t.string :manufacturer_item_no_2
      t.string :manufacturer_code
      t.decimal :net_weight
      t.decimal :gross_weight
      t.boolean :webshop_release

      t.timestamps
    end

    add_index :spree_navision_items, :key, unique: true
  end
end
