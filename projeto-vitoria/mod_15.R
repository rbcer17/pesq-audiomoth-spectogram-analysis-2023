##MODULO 15 BIOLOGIA QUANTITATIVA 

#Calculo do indice de complexidade acustica####
library(tuneR)
library(soundecology)
rm(list=ls())

filesWave <- list.files("C:/Users/UnB/Downloads/BIOQUANT",pattern="*.WAV", full.names=TRUE)

sndcupimco1 <- readWave(filesWave[1])
acicupimco1 <- acoustic_complexity(sndcupimco1, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
filesWave[1] <- sub("C:/Users/UnB/Downloads/BIOQUANT","",filesWave[1])
Newrow <- c(filesWave[1],acicupimco1)
Dataframe <- Newrow


for(i in 2:length(filesWave)){
  sndcupimco1 <- readWave(filesWave[i])
  acicupimco1 <- acoustic_complexity(sndcupimco1, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
  filesWave[i] <- sub("C:/Users/UnB/Downloads/BIOQUANT","",filesWave[i])
  Newrow <- c(filesWave[i],acicupimco1)
  Dataframe <- rbind(Dataframe,Newrow)
}
colnames(Dataframe)[1] <- "Waves"

write.csv(Dataframe,"Indices_Acusticos.csv", row.names = FALSE, )

#criando vetores dos audios
a_110000<- readWave("20220818_110000.WAV")
a_111500<- readWave("20220818_111500.WAV")
a_114500<-readWave("20220818_114500.WAV")
a_120000<-readWave("20220818_120000.WAV")
a_121500<-readWave("20220818_121500.WAV")
a_123000<-readWave("20220818_123000.WAV")

#calculo da complexidade 
ac_110000<-acoustic_complexity(a_110000, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
ac_111500<-acoustic_complexity(a_111500, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
ac_114500<-acoustic_complexity(a_114500, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
ac_120000<-acoustic_complexity(a_120000, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
ac_121500<-acoustic_complexity(a_121500, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
ac_123000<-acoustic_complexity(a_123000, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)

ac_110000L=ac_110000$AciTotAll_left
ac_111500L=ac_111500$AciTotAll_left
ac_114500L=ac_114500$AciTotAll_left
ac_120000L=ac_120000$AciTotAll_left
ac_121500L=ac_121500$AciTotAll_left
ac_123000L=ac_123000$AciTotAll_left

##IMAGENS 
install.packages("jpeg")
library("jpeg")

filesjpeg <- list.files("C:/Users/UnB/Downloads/img jpeg audios", full.names=TRUE)
img<-readJPEG(filesjpeg[1])

##Calculo da complexidade das imagens:

img_110000<-img_complexity("20220818_110000.jpeg", algorithm = "zip", rotate = FALSE) # 0.5721025 
img_111500<-img_complexity("20220818_111500.jpeg", algorithm = "zip", rotate = FALSE) # 0.5678088
img_114500<-img_complexity("20220818_114500.jpeg", algorithm = "zip", rotate = FALSE) # 0.5739901
img_120000<-img_complexity("20220818_120000.jpeg", algorithm = "zip", rotate = FALSE) # 0.5630119
img_121500<-img_complexity("20220818_121500.jpeg", algorithm = "zip", rotate = FALSE) # 0.5714099
img_123000<-img_complexity("20220818_123000.jpeg", algorithm = "zip", rotate = FALSE) # 0.5715803

x= c(img_110000,img_111500,img_114500,img_120000,img_121500,img_123000)
y=c(ac_110000L,ac_111500L,ac_114500L,ac_120000L,ac_121500L,ac_123000L)
teste<-data.frame(x,y)

grafico<-plot(x,y)
abline(reg=lm(y~x))


#http://samcarcagno.altervista.org/blog/basic-sound-processing-r/?doing_wp_cron=1608062613.5910539627075195312500
# http://ljvillanueva.github.io/soundecology/














