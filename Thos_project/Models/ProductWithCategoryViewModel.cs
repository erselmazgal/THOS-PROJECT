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
<<<<<<< HEAD
        public decimal PriceInUSD { get; set; }     // Dolar cinsinden fiyat
        public decimal PriceInEUR { get; set; }     // Euro cinsinden fiyat
=======
>>>>>>> 7174e52c49f9b83c9c3fbed47577088eea6d9c45
    }
}