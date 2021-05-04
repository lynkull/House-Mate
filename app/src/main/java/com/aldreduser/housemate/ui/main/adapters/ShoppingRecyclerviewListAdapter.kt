package com.aldreduser.housemate.ui.main.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.aldreduser.housemate.R
import com.aldreduser.housemate.data.model.ShoppingItem

// This is the list recyclerview adapter
class ShoppingRecyclerviewListAdapter(private val shoppingItems: ArrayList<ShoppingItem>):
    RecyclerView.Adapter<ShoppingRecyclerviewListAdapter.DataViewHolder>() {

    private val shoppingItemLayout = R.layout.shopping_item_layout

    class DataViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind(shoppingItem: ShoppingItem) {
            //itemView.textViewUserName.text = shoppingItem.name   //todo: change the view name to an appropriate one
            //itemView.textViewUserEmail.text = shoppingItem.quantity.toString()     //todo: change the view name to an appropriate one
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = DataViewHolder(
        LayoutInflater.from(parent.context).inflate(shoppingItemLayout, parent, false)
    )

    override fun onBindViewHolder(holder: DataViewHolder, position: Int) =
        holder.bind(shoppingItems[position])

    override fun getItemCount(): Int = shoppingItems.size

    // not a default function from the interface
    fun addData(list: List<ShoppingItem>) {
        shoppingItems.addAll(list)
    }
}