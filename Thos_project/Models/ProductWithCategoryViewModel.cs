using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Thos_project.Models
{
    public class ProductWithCategoryViewModel
    {
        public string ProductName { get; set; }    // Ürün adı
        public decimal Price { get; set; }          // Ürün fiyatı
        public string CategoryName { get; set; }    // Kategori adı
        public string ImagePath { get; set; }    // Kategori adı
    }
}