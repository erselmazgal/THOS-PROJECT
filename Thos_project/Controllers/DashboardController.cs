using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;
using Thos_project.DAL;
using Thos_project.Models;

namespace Thos_project.Controllers
{

    [AdminFilter]
    public class DashboardController : Controller
    {
        private ThosCafeTaskDB _context = new ThosCafeTaskDB();

        public ActionResult Index()
        {
            // Kategori ve ürün sayısı bilgisi
            ViewBag.CategoryCount = _context.Category.Count(c => !c.IsDeleted);
            ViewBag.ProductCount = _context.Product.Count(p => !p.IsDeleted);

            var exchangeRates = GetExchangeRate();
           
            ViewBag.UsdRate = exchangeRates.USD;
            ViewBag.EuroRate = exchangeRates.EUR; // Euro kuru için
            ViewBag.GBPRate = exchangeRates.GBP; // GBP kuru için

            // Döviz kuru bilgisi
            ViewBag.ExchangeRate = GetExchangeRate();
            return View();
        }


        private ExchangeRates GetExchangeRate()
        {
            using (var client = new WebClient())
            {
                string url = "http://www.tcmb.gov.tr/kurlar/today.xml";
                var data = client.DownloadString(url);

                // Döviz kuru bilgisi XML'den ayrıştırılır
                XDocument doc = XDocument.Parse(data);

                var exchangeRates = new ExchangeRates
                {
                    USD = doc.Descendants("Currency")
                        .Where(x => (string)x.Attribute("CurrencyCode") == "USD")
                        .Select(x => (string)x.Element("ForexSelling"))
                        .FirstOrDefault(),
                    EUR = doc.Descendants("Currency")
                        .Where(x => (string)x.Attribute("CurrencyCode") == "EUR")
                        .Select(x => (string)x.Element("ForexSelling"))
                        .FirstOrDefault(),
                    GBP = doc.Descendants("Currency")
                        .Where(x => (string)x.Attribute("CurrencyCode") == "GBP")
                        .Select(x => (string)x.Element("ForexSelling"))
                        .FirstOrDefault()
                };

                return exchangeRates;
            }
        }

        public class ExchangeRates
        {
            public string USD { get; set; }
            public string EUR { get; set; }
            public string GBP { get; set; }
        }

    }
}