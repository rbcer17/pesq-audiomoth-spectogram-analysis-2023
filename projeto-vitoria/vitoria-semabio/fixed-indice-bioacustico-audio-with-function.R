## AUDIO

## importando a lista de wav e criando um dataframe com a acoustic complexity dos audios
rm(list=ls())

library(tuneR)
library(soundecology)

wav_names <- list.files(pattern = "*.WAV")     
wav_names
######
bioacoustmake <- function(r){
  audioread <- readWave(r)
  bioacust <- bioacoustic_index(audioread, min_freq = 2000, max_freq = 8000, fft_w = 512)  
  return(bioacust)
  }
###############
bioacoust_list <- lapply(wav_names, bioacoustmake)
#to remove right area right channel not calculated from list:
#l3 <- lapply(bioacoust_list, function(x) x[names(x) != 'right_area'])
bioacoustframe <- data.frame(unlist(bioacoust_list))
bioacoustframe <- na.omit(bioacoustframe)
bioacoust_dataframe = data.frame(unlist(wav_names),bioacoustframe)
#bioacoust_dataframetest = as.data.frame(unlist(wav_names))
# also can use
#bioacoust_dataframe2 = data.frame(unlist(wav_names),unlist(l3))
names(bioacoust_dataframe) = c("nome_arquivo","bioacous_audio")#renomeando
rownames(bioacoust_dataframe) <- NULL
#
##########
# Removendo sufixo WAV dos nomes de arquivos do dataframe bioacoust_dataframe
bioacoust_dataframe['nome_arquivo'] <- gsub("\\..*","",bioacoust_dataframe$nome_arquivo) # Removendo .WAV
#bioacoust_dataframe['nome_arquivo'] <- gsub('.$', '', #bioacoust_dataframe$nome_arquivo)
#
###### GRAVANDO INDICES BIOACUSTICOS
write.csv(bioacoust_dataframe,"indices_bioacusticos.csv", row.names = FALSE, )


#### IMAGENS #######

######## CRIANDO DATAFRAME COM INDICE COMPLEXIDADE IMAGENS 

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
#dataframe_img['nome_arquivo'] <- gsub('.$', '', dataframe_img$nome_arquivo)


####### Unindo dataframes AUDIO  E IMAGEM#####

library("dplyr")
df_img_audio <- merge(dataframe_img,bioacoust_dataframe,by="nome_arquivo")
#Remove rows where gender not equal to 'm'

#dfsem2000 <- subset(df_img_audio, bioacoustic_index()<2000 )
#dfsem2000


plot(df_img_audio$complexidade_img, df_img_audio$bioacous_audio,
     xlab = "complexidade_img", ylab = "bioindex_audio")

vector_aud = as.numeric(df_img_audio$bioacous_audio)
vector_img = as.numeric(df_img_audio$complexidade_img)

reg= lm(vector_aud~vector_img)
abline(reg)
summary(reg)
cor.test(vector_aud,vector_img)

#Salvando dados 
write.csv(dataframe_img,"dataframe_img.csv", row.names = FALSE, )
write.csv(df_img_audio,"df_img_audio.csv", row.names = FALSE, )
write.csv(dataframe_img,"dataframe_img.csv", row.names = FALSE, )
write.csv(bioacoust_dataframe,"bioacouts_dataframe.csv", row.names = FALSE, )


















