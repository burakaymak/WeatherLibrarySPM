# 🌤️ WeatherLibrary

**WeatherLibrary**, iOS projelerinde kolayca hava durumu verisi almak için geliştirilmiş bir Swift Package’dır.  
Kullanıcıların bulunduğu konum bilgisi üzerinden **OpenWeatherMap API**’den anlık hava durumu verilerini çekmenizi sağlar.  

---

## ✨ Özellikler
- 📍 Latitude & longitude bilgisi üzerinden API çağrısı yapar  
- 🌡️ Sıcaklık (`temperature`) ve hissedilen sıcaklık (`feelsLike`) bilgisi döner  
- ☁️ Hava durumu açıklamasını (`description`) sağlar  
- 🏙️ Bulunduğunuz lokasyonun adını getirir  
- ⚠️ Hata durumlarını kolayca yakalayabilmeniz için `Result` yapısı kullanır  

---

## 📦 Kurulum

### Swift Package Manager
Xcode üzerinden:  

1. `File > Add Packages...` menüsüne gidin  
2. Aşağıdaki repo URL’sini ekleyin:  

```text
https://github.com/burakaymak/WeatherLibrary.git
