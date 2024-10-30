using System;
using System.IO; // Path işlemleri için
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Thos_project.DAL;
using Thos_project.Models;

namespace Thos_project.Controllers
{
    [AdminFilter]
    public class ProductController : Controller
    {
        private ThosCafeTaskDB _context = new ThosCafeTaskDB();

        // Ürünleri listele
        public ActionResult Index()
        {
            var products = _context.Product.Where(p => !p.IsDeleted).ToList();
            return View(products);
        }

        // Yeni ürün ekle
        public ActionResult Create()
        {
            ViewBag.Categories = new SelectList(_context.Category.Where(c => !c.IsDeleted), "CategoryId", "CategoryName");
            return View();
        }
        [HttpPost]
        public ActionResult Create(Product product, HttpPostedFileBase ImagePath)
        {
            if (ModelState.IsValid)
            {
                if (ImagePath != null && ImagePath.ContentLength > 0)
                {
                    var uploadDirectory = Server.MapPath("~/UploadedImages");
                    if (!Directory.Exists(uploadDirectory))
                    {
                        Directory.CreateDirectory(uploadDirectory);
                    }

                    var fileName = Path.GetFileName(ImagePath.FileName);
                    var path = Path.Combine(uploadDirectory, fileName);
                    ImagePath.SaveAs(path);

                    product.ImagePath = fileName; // Yüklenen dosya adını kaydedin
                }

                product.CreatedDate = DateTime.Now;
                _context.Product.Add(product);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Categories = new SelectList(_context.Category, "CategoryId", "CategoryName");
            return View(product);
        }



        // Ürün düzenle
        public ActionResult Edit(int id)
        {
            var product = _context.Product.Find(id);
            ViewBag.Categories = new SelectList(_context.Category, "CategoryId", "CategoryName", product.CategoryId);
            return View(product);
        }

        [HttpPost]
        public ActionResult Edit(Product product, HttpPostedFileBase ImageUpload, int id)
        {
            if (ModelState.IsValid)
            {
                var existingProduct = _context.Product.Find(id); // ID'yi kullanarak mevcut ürünü bul
                if (existingProduct == null)
                {
                    return HttpNotFound(); // Kayıt bulunamazsa hata döndür
                }

                // Var olan kaydın değerlerini güncelle
                existingProduct.ProductName = product.ProductName;
                existingProduct.Price = product.Price;
                existingProduct.CategoryId = product.CategoryId;

                // Resim güncelleme işlemi
                if (ImageUpload != null && ImageUpload.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(ImageUpload.FileName);
                    var path = Path.Combine(Server.MapPath("~/UploadedImages/"), fileName);
                    ImageUpload.SaveAs(path);
                    existingProduct.ImagePath = "/Images/" + fileName; // Resmin yolunu güncelle
                }

                // Eğer resim yüklenmediyse, mevcut resmi koru
                if (string.IsNullOrEmpty(existingProduct.ImagePath))
                {
                    ModelState.AddModelError("", "Mevcut resim yok, yeni bir resim yükleyin.");
                }

                // Diğer özellikleri de güncelle
                _context.SaveChanges(); // Değişiklikleri kaydet

                return RedirectToAction("Index");
            }

            // Kayıt bulunamazsa veya model geçersizse formu yeniden göster
            ViewBag.Categories = new SelectList(_context.Category, "CategoryId", "CategoryName", product.CategoryId);
            return View(product);
        }




        // Ürün sil
        public ActionResult Delete(int id)
        {
            var product = _context.Product.Find(id);
            return View(product);
        }

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            var product = _context.Product.Find(id);
            product.IsDeleted = true;
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
