using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Mvc;
using Thos_project.DAL;
using Thos_project.Models;
using Thos_project.Services;

namespace Thos_project.Controllers
{
    public class ProductCustomerController : Controller
    {
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
