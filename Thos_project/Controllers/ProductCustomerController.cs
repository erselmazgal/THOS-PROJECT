using System;
<<<<<<< HEAD
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Mvc;
using Thos_project.DAL;
using Thos_project.Models;
using Thos_project.Services;
=======
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Thos_project.DAL;
using Thos_project.Models;
>>>>>>> 7174e52c49f9b83c9c3fbed47577088eea6d9c45

namespace Thos_project.Controllers
{
    public class ProductCustomerController : Controller
    {
<<<<<<< HEAD
        private readonly ThosCafeTaskDB _context = new ThosCafeTaskDB();
        private readonly ExchangeRateService _exchangeRateService = new ExchangeRateService();

        //public ProductCustomerController(ThosCafeTaskDB context, ExchangeRateService exchangeRateService)  //test için aktif et
        //{
        //    _context = context;
        //    _exchangeRateService = exchangeRateService;
        //}

        public ActionResult Index()
        {
            // Döviz kurlarını al
            var (usdRate, eurRate) = _exchangeRateService.GetExchangeRates();

=======
        private ThosCafeTaskDB _context = new ThosCafeTaskDB();

        // GET: ProductCustomer
        public ActionResult Index()
        {
>>>>>>> 7174e52c49f9b83c9c3fbed47577088eea6d9c45
            var productsWithCategories = _context.Product
                .Where(p => !p.IsDeleted)
                .Join(_context.Category,
                    product => product.CategoryId,
                    category => category.CategoryId,
                    (product, category) => new ProductWithCategoryViewModel
                    {
                        ProductName = product.ProductName,
                        Price = product.Price,
                        CategoryName = category.CategoryName,
<<<<<<< HEAD
                        ImagePath = product.ImagePath,
                        PriceInUSD = 0, // Başlangıçta 0, sonradan hesaplanacak
                        PriceInEUR = 0  // Başlangıçta 0, sonradan hesaplanacak
                    })
                .ToList();
            foreach (var product in productsWithCategories)
            {
                product.PriceInUSD = Math.Round(product.Price / usdRate, 2); // TL'den USD'ye çevir
                product.PriceInEUR = Math.Round(product.Price / eurRate, 2); // TL'den EUR'ya çevir
            }

            return View(productsWithCategories);
        }
    }
}
=======
                        ImagePath = product.ImagePath // ImagePath'i ekliyoruz
                    })
                .ToList();

            return View(productsWithCategories);
        }

    }
}
>>>>>>> 7174e52c49f9b83c9c3fbed47577088eea6d9c45
