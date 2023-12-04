## importando a lista de wav e criando um dataframe com a acoustic complexity dos audios

library(tuneR)
library(soundecology)

wav_names <- list.files(pattern = "*.WAV")     
wav_names
######
acimake <- function(r){
  audioread <- readWave(r)
  complexacust <- acoustic_complexity(audioread, min_freq = NA, max_freq = NA, j = 5, fft_w = 512) 
  return(complexacust)
}
###############
aci_list <- lapply(wav_names, acimake)
aci_dataframe = data.frame(unlist(wav_names),unlist(aci_list))
##########
audioread <- readWave(wav_names[1])
complexacust <- acoustic_complexity(audioread, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
iniciarquivo <- c(wav_names[1],complexacust)
arquivodados <- iniciarquivo
####

##########
for(i in 2:length(wav_names)){
  audioread <- readWave(wav_names[i])
  complexacust <- acoustic_complexity(audioread, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
  continuararquivo <- c(wav_names[i],complexacust)
  arquivodados <- rbind(arquivodados,continuararquivo)
}
############################
resultado <- as.data.frame(arquivodados)

colnames(Dataframe)[1] <- "Waves"
View(DATA)

write.csv(Dataframe,"Indices_Acusticos.csv", row.names = FALSE, )
#####

####
img_complex_list <- lapply(jpeg_names, img_complexity)

## List --> Data frame 

indice_complexidade = data.frame(unlist(jpeg_names),unlist(img_complex_list))

#to name the columns we use names() function
names(indice_complexidade) = c("nomeimagem","indice")






















