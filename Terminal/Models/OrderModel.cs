using Microsoft.AspNetCore.Components;
using System.ComponentModel.DataAnnotations;

namespace RIVA.Models
{
    public class OrderModel : ComponentBase
    {
        public int id { get; set; }
        public int user_id { get; set; }
        public string order_description { get; set; }
        public int total_price { get; set; }
        public int table_number { get; set; }
        public string order_status { get; set; }
        public string payment_method { get; set; }
        public string payment_status { get; set; }
        public int restaurant_id { get; set; }
        public string created_at { get; set; }
        public string updated_at { get; set; }
    }

    public class OrderRoot
    {
        public int total_size { get; set; }
        public List<OrderModel> orders { get; set; }
    }
}
