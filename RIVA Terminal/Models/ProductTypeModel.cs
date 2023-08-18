using System.ComponentModel.DataAnnotations;

namespace RIVA.Models
{
    public class ProductTypeModel
    {
        public int id { get; set; }

        [Display(Name = "Category")]
        [DataType(DataType.Text)]
        public string title { get; set; }
        public int parent_id { get; set; }
        public string created_at { get; set; }
        public string updated_at { get; set; }
        public int order { get; set; }
        public string description { get; set; }
        public string img { get; set; }
    }

    public class ProductTypeRoot
    {
        public int total_size { get; set; }
        public int parent_id { get; set; }
        public List<ProductTypeModel> product_types { get; set; }
    }
}
