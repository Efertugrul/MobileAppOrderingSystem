using Microsoft.AspNetCore.Components;
using System.ComponentModel.DataAnnotations;

namespace RIVA.Models
{
    public class LocationModel : ComponentBase
    {
        public int id { get; set; }

        //[RegularExpression("[0-9]{6}", ErrorMessage = "Client No must be a 6 digit number")]
        [Display(Name = "Address Type")]
        [DataType(DataType.Text)]
        public string address_type { get; set; }

        [Display(Name = "Address")]
        [DataType(DataType.Text)]
        public string address { get; set; }

        [RegularExpression("[0-9.]{1,}$", ErrorMessage = "Latitude must be a float value")]
        [Display(Name = "Latitude")]
        [DataType(DataType.Text)]
        public string latitudeTxt { get; set; }
        public double latitude { get; set; }

        [RegularExpression("[0-9.]{1,}$", ErrorMessage = "Longitude must be a float value")]
        [Display(Name = "Longitude")]
        [DataType(DataType.Text)]
        public string longitudeTxt { get; set; }
        public double longitude { get; set; }

        [Display(Name = "Type Id")]
        [DataType(DataType.Text)]
        public string type_idTxt { get; set; }
        public int type_id { get; set; }

        public string? created_at { get; set; }
        public string? updated_at { get; set; }
    }

    public class LocationRoot
    {
        public int total_size { get; set; }
        public int type_id { get; set; }
        public List<LocationModel> locations { get; set; }
    }
}
