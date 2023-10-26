##################### IMAGENS ################

## importando a lista de jpg e criando um dataframe com a img_complexity dos jpgs
rm(list=ls())

install.packages("imagefluency")
library("imagefluency")

jpeg_names <- list.files(pattern = "*.jpg")
jpeg_names

img_complex_list <- lapply(jpeg_names, img_complexity)

# List -> Data frame 
dataframe_img = data.frame(unlist(jpeg_names),unlist(img_complex_list))

names(dataframe_img) = c("nome_arquivo","complexidade_img") #renomeando
dataframe_img['nome_arquivo'] <- gsub("\\..*","",dataframe_img$nome_arquivo) # Removendo .JPG
dataframe_img['nome_arquivo'] <- gsub('.$', '', dataframe_img$nome_arquivo)


###################### AUDIOS ################

## importando a lista de wav e criando um dataframe com a acoustic complexity dos audios
rm(list=ls())

library(tuneR)
library(soundecology)

wav_names <-list.files(pattern = "*.WAV")
waves2<-gsub("\\..*","",wav_names)

####
audioread <- readWave(wav_names[1])
complexacust <- acoustic_complexity(audioread, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
iniciarquivo <- c(waves2 [1],complexacust)
arquivodados <- iniciarquivo

####
for(i in 2:length(wav_names)){
  audioread <- readWave(wav_names[i])
  complexacust <- acoustic_complexity(audioread, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)
  continuararquivo <- c(waves2[i],complexacust)
  arquivodados <- rbind(arquivodados,continuararquivo)
}

####
resultado <- as.data.frame(arquivodados)

resultado_audio <- subset(resultado, select = -c(AciTotAll_right, AciTotAll_right_bymin, aci_fl_left_vals, aci_left_matrix, 
                                                 aci_right_matrix, aci_fl_right_vals, AciTotAll_left_bymin))
colnames(resultado_audio)[1] <- "Waves"
names(resultado_audio) = c("nome_arquivo","complexidade_audio") #renomeando


################ Unindo dataframes #####

library("dplyr")
df_img_audio <- merge(dataframe_img,resultado_audio,by="nome_arquivo")

plot(df_img_audio$complexidade_img, df_img_audio$complexidade_audio,
     xlab = "complexidade_img", ylab = "complexidade_audio")





