using System;
using System.Globalization;
using System.Linq;
using System.Net.Http;
using System.Xml.Linq;

namespace Thos_project.Services // Bu namespace'i projenizin genel yapısına göre ayarlayın
{
    public class ExchangeRateService
    {
        public virtual (decimal USD, decimal EUR) GetExchangeRates()
        {
            using (HttpClient client = new HttpClient())
            {
                var response = client.GetStringAsync("http://www.tcmb.gov.tr/kurlar/today.xml").Result;

                // XML'i parse et
                var xml = XDocument.Parse(response);

                var usdElement = xml.Descendants("Currency")
                    .FirstOrDefault(c => (string)c.Attribute("Kod") == "USD");

                var eurElement = xml.Descendants("Currency")
                    .FirstOrDefault(c => (string)c.Attribute("Kod") == "EUR");

                if (usdElement == null)
                {
                    throw new Exception("USD döviz bilgisi alınamadı. Lütfen API yanıtını kontrol edin.");
                }

                if (eurElement == null)
                {
                    throw new Exception("EUR döviz bilgisi alınamadı. Lütfen API yanıtını kontrol edin.");
                }

                // Döviz kurlarını al
                var usdRateString = (string)usdElement.Element("ForexSelling");
                var eurRateString = (string)eurElement.Element("ForexSelling");

                // "M" ve boşlukları temizle, virgülü nokta ile değiştir
                usdRateString = usdRateString.TrimEnd('M', ' ', '\r', '\n');
                eurRateString = eurRateString.TrimEnd('M', ' ', '\r', '\n');

                // Dönüşüm işlemini yaparken virgül ve nokta dönüşümünü kontrol et
                var usdRate = decimal.Parse(usdRateString, CultureInfo.InvariantCulture);
                var eurRate = decimal.Parse(eurRateString, CultureInfo.InvariantCulture);

                return (usdRate, eurRate);
            }
        }



    }
}
