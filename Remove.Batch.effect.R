library(limma)

methylation_data <- read.table("/labmed/06.AML/Result/04.Normal/", header = TRUE)
methylation_data <- na.omit(methylation_data)
Position <- methylation_data[,c(1,2,3)]
Normal <- methylation_data[, 28:45]
AML <- methylation_data[, 4:27]
Total <- cbind(AML, Normal)

#Total batch
AML_batch <- rep(c('Batch1', 'Batch2'), c(24, 18))

# Batch effect 제거
AML_data <- removeBatchEffect(Total , AML_batch)

AML_scaled_data <- AML_data
AML_scaled_data[AML_scaled_data < 0] <- 0
AML_scaled_data[AML_scaled_data > 100] <- 100

Data1 <- cbind(Position, round(AML_scaled_data, digits=2))
write.table(Data1, 'Result/04.Normal/Normalized.scaled.txt', sep='\t', quote=F, row.names = F, col.names = T)
