namespace RIVA.Models
{
    public class ProductModel
    {
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public int price { get; set; }
        public int stars { get; set; }
        public string img { get; set; }
        public string location { get; set; }
        public string created_at { get; set; }
        public string updated_at { get; set; }
        public int type_id { get; set; }
    }

    public class ProductRoot
    {
        public int total_size { get; set; }
        public int type_id { get; set; }
        public int offset { get; set; }
        public List<ProductModel> products { get; set; }
    }
}
