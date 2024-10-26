Proje Adı
Proje Açıklaması
Bu proje, bir müşteri ve admin yönetim sistemidir. Kullanıcıların müşteri girişi yaparak sisteme erişebilmesini ve admin kullanıcıların yönetim paneline giriş yaparak yönetim işlemlerini gerçekleştirmesini sağlar.

Gereksinimler
Microsoft SQL Server
Visual Studio (ASP.NET MVC projesi için)
Kurulum Adımları
1. SQL Script Dosyasını Çalıştırma
Öncelikle, veritabanınızı oluşturmak ve gerekli tabloları doldurmak için SQL script dosyasını çalıştırmalısınız.

SQL Server Management Studio'yu (SSMS) Açın:

SQL Server'a bağlanın.
Script Dosyasını Çalıştırın:

Script dosyanızı açın.
Aşağıdaki SQL sorgusunu çalıştırarak gerekli veritabanı ve tabloları oluşturun.
Örnek SQL sorgusu:

-- Veritabanı ve tabloların oluşturulması için gerekli script
-- (Scriptinizi buraya yapıştırın veya açın ve çalıştırın)
2. Visual Studio'da Projeyi Açma
Visual Studio'yu Açın:

Projenizin dizinini bulun ve projeyi açın.
Projeyi Çalıştırma:

Projeyi çalıştırmak için "Start" butonuna (F5) tıklayın.
3. Kullanıcı Girişi
Projeniz çalıştığında, kullanıcı giriş ekranına yönlendirileceksiniz. Aşağıdaki bilgileri kullanarak giriş yapabilirsiniz:

Müşteri Girişi:
Kullanıcı Adı: hasan
Şifre: 123
Admin Paneli Girişi:
Kullanıcı Adı: admin
Şifre: 1234
4. Sorun Giderme
Eğer giriş yaparken bir sorun ile karşılaşırsanız, aşağıdaki adımları kontrol edin:

Kullanıcı adı ve şifreyi doğru girdiğinizden emin olun.
Veritabanı bağlantı ayarlarınızı kontrol edin.
