class HomeController < ActionController::Base

  def dashboard
  end

  def bill
    @purchase_array = params[:name].split(",");
    @bill_customer = @purchase_array.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
    calculate_item
  end

  private

  def calculate_item
    item_total = 0
    @save_total = 0
    @sub_total = 0
    real_total = 0
    @key_array=[]
    @value_array=[]
    @item_total_array = []


    @bill_customer.each do |key, value|
      if key=="banana"
        item_total = (value * 0.99)
      elsif key=="apple"
        item_total = (value * 0.89)
      elsif key=="milk"
        if value > 1
          item_total = (value / 2 * 5.00) + (value % 2 * 3.97 )
        else
          item_total = (value * 3.97)
        end
         real_total = value * 3.17
      else
       if value > 2
         item_total = (value / 3 * 6.00) + (value % 3 * 2.17 )
       else
         item_total = (value * 2.17)
       end
        real_total = value * 2.17
      end
      @sub_total += item_total  
      @item_total_array << item_total
      @key_array << key
      @value_array << value

      if real_total > 0
        @save_total += real_total - item_total
      end

      item_total = 0
      real_total =0  
 
    end  
  end 

end
