######################服务器地址
args=commandArgs(T)
path=args[1]
output=args[2]
print(path)
print(output)
# path='/pnas/yangyg_group/zhangting/SBY_structure-m5C-new2/0_RBP/window-may23/w10_s10/pic/Figure2C/01_001/'
# output="01_001-down"
x1 <- paste(path,"up/annotation/egg_cell1-anno.bed",sep='')
x2 <- paste(path,"up/annotation/cell1_cell4-anno.bed",sep='')
x3 <- paste(path,"up/annotation/cell4_cell64-anno.bed",sep='')
x4 <- paste(path,"up/annotation/cell64_sphere-anno.bed",sep='')
x5 <- paste(path,"up/annotation/sphere_shield-anno.bed",sep='')

library(data.table)
options(stringsAsFactors=F)
stage1 <- fread(x1, sep='\t')
stage2 <- fread(x2, sep='\t')
stage3 <- fread(x3, sep='\t')
stage4 <- fread(x4, sep='\t')
stage5 <- fread(x5, sep='\t')

stage1 <- data.frame(stage1)
stage2 <- data.frame(stage2)
stage3 <- data.frame(stage3)
stage4 <- data.frame(stage4)
stage5 <- data.frame(stage5)

stage1.utr5 <- stage1[grepl("utr5",stage1[,8]),]
stage1.cds <- stage1[grepl("cds",stage1[,8]),]
stage1.utr3 <- stage1[grepl("utr3",stage1[,8]),]

stage2.utr5 <- stage2[grepl("utr5",stage2[,8]),]
stage2.cds <- stage2[grepl("cds",stage2[,8]),]
stage2.utr3 <- stage2[grepl("utr3",stage2[,8]),]


stage3.utr5 <- stage3[grepl("utr5",stage3[,8]),]
stage3.cds <- stage3[grepl("cds",stage3[,8]),]
stage3.utr3 <- stage3[grepl("utr3",stage3[,8]),]

stage4.utr5 <- stage4[grepl("utr5",stage4[,8]),]
stage4.cds <- stage4[grepl("cds",stage4[,8]),]
stage4.utr3 <- stage4[grepl("utr3",stage4[,8]),]

stage5.utr5 <- stage5[grepl("utr5",stage5[,8]),]
stage5.cds <- stage5[grepl("cds",stage5[,8]),]
stage5.utr3 <- stage5[grepl("utr3",stage5[,8]),]


plot.data <- cbind(c(dim(stage5.utr5)[1],dim(stage5.cds)[1],dim(stage5.utr3)[1]),
c(dim(stage4.utr5)[1],dim(stage4.cds)[1],dim(stage4.utr3)[1]),
c(dim(stage3.utr5)[1],dim(stage3.cds)[1],dim(stage3.utr3)[1]),
c(dim(stage2.utr5)[1],dim(stage2.cds)[1],dim(stage2.utr3)[1]),
c(dim(stage1.utr5)[1],dim(stage1.cds)[1],dim(stage1.utr3)[1]))

colnames(plot.data) <- rev(c("Egg->1 Cell", "1 Cell->4 Cell","4 Cell->64 Cell","64 Cell->Sphere","Sphere->Shield"))
plot.data.used <- plot.data
plot.data.used[,1] <- plot.data.used[,1]/sum(plot.data.used[,1])
plot.data.used[,2] <- plot.data.used[,2]/sum(plot.data.used[,2])
plot.data.used[,3] <- plot.data.used[,3]/sum(plot.data.used[,3])
plot.data.used[,4] <- plot.data.used[,4]/sum(plot.data.used[,4])
plot.data.used[,5] <- plot.data.used[,5]/sum(plot.data.used[,5])


#png(paste(output,".png",sep=''))
pdf(paste(output,".pdf",sep=''))
par(lwd=3, cex.axis=1.5, cex.lab=2.5, mar=c(10,10,6,8), las=1)	
barplot(plot.data.used, horiz=T, col=c("tomato", "limegreen", "skyblue"), lwd=3, ylim=c(0,2), xlim=c(0,1), xlab='', ylab='', width=0.25,legend.text=c("5'UTR","CDS","3'UTR"), args.legend = list(x=1.4, y=0.5,bg="white"),tcl=-1.4)
dev.off()



###################################normalization
ratio <- c(150,1250,460)/sum(c(150,1250,460))
plot.data.used <- plot.data
plot.data.used[,1] <- plot.data.used[,1]/ratio
plot.data.used[,2] <- plot.data.used[,2]/ratio
plot.data.used[,3] <- plot.data.used[,3]/ratio 
plot.data.used[,4] <- plot.data.used[,4]/ratio
plot.data.used[,5] <- plot.data.used[,5]/ratio

plot.data.used[,1] <- plot.data.used[,1]/sum(plot.data.used[,1])
plot.data.used[,2] <- plot.data.used[,2]/sum(plot.data.used[,2])
plot.data.used[,3] <- plot.data.used[,3]/sum(plot.data.used[,3])
plot.data.used[,4] <- plot.data.used[,4]/sum(plot.data.used[,4])
plot.data.used[,5] <- plot.data.used[,5]/sum(plot.data.used[,5])

transNum <- c(length(unique(stage1[,1])),
			length(unique(stage2[,1])),
			length(unique(stage3[,1])),
			length(unique(stage4[,1])),
			length(unique(stage5[,1])))

utr3Num <- c(length(unique(stage1.utr3[,1])),
			length(unique(stage2.utr3[,1])),
			length(unique(stage3.utr3[,1])),
			length(unique(stage4.utr3[,1])),
			length(unique(stage5.utr3[,1])))	

utr5Num <- c(length(unique(stage1.utr5[,1])),
			length(unique(stage2.utr5[,1])),
			length(unique(stage3.utr5[,1])),
			length(unique(stage4.utr5[,1])),
			length(unique(stage5.utr5[,1])))	

cdsNum <- c(length(unique(stage1.cds[,1])),
			length(unique(stage2.cds[,1])),
			length(unique(stage3.cds[,1])),
			length(unique(stage4.cds[,1])),
			length(unique(stage5.cds[,1])))	


trans_winNum <- c(length(stage1[,1]),
			length(stage2[,1]),
			length(stage3[,1]),
			length(stage4[,1]),
			length(stage5[,1]))

utr3_winNum <- c(length(stage1.utr3[,1]),
			length(stage2.utr3[,1]),
			length(stage3.utr3[,1]),
			length(stage4.utr3[,1]),
			length(stage5.utr3[,1]))	

utr5_winNum <- c(length(stage1.utr5[,1]),
			length(stage2.utr5[,1]),
			length(stage3.utr5[,1]),
			length(stage4.utr5[,1]),
			length(stage5.utr5[,1]))	

cds_winNum <- c(length(stage1.cds[,1]),
			length(stage2.cds[,1]),
			length(stage3.cds[,1]),
			length(stage4.cds[,1]),
			length(stage5.cds[,1]))	
			
			
			
transcript <- rbind(transNum, utr5Num, cdsNum, utr3Num)			
winNum <- rbind(trans_winNum, utr5_winNum, cds_winNum, utr3_winNum)	
res <- matrix(paste(winNum, transcript, sep="/"), nrow=4, byrow=F)
write.table(res, paste(output,"-count.txt",sep=""), sep="\t", quote=F, row.names=F, col.names=F)

colnames(plot.data.used) <- rev(c("Egg->1 Cell", "1 Cell->4 Cell","4 Cell->64 Cell","64 Cell->Sphere","Sphere->Shield"))
#png(paste(output,"-norm.png",sep=""))
pdf(paste(output,"-norm.pdf",sep=""))
par(lwd=3, cex.axis=1.5, cex.lab=2.5, mar=c(10,10,6,8), las=1)	
barplot(plot.data.used, horiz=T, col=c("tomato", "limegreen", "skyblue"), lwd=3, ylim=c(0,2), xlim=c(0,1), xlab='', ylab='', width=0.25,legend.text=c("5'UTR","CDS","3'UTR"), args.legend = list(x=1.4, y=0.5,bg="white"),tcl=-1.4)
dev.off()
	

########################算富集的分
utr3 <- read.table("/pnas/yangyg_group/zhangting/Reference/Zebrafish/Refseq_v10/GeneList/whole-trans/UTR3.txt",sep="\t", stringsAsFactors=F)
transcript <- read.table("/pnas/yangyg_group/zhangting/Reference/Zebrafish/Refseq_v10/GeneList/whole-trans/wholeTransPositionDetail.txt",sep="\t", stringsAsFactors=F)

utr3.index <- grepl("NM_",utr3[,1])
utr3 <- sapply(strsplit(utr3[utr3.index,1],"_"),function(fn){as.numeric(fn[3])})
transcript.index <- grepl("Transcript",transcript[,2])
transcript <- as.numeric(transcript[transcript.index,3])

ratio <- c(150,1250,460)/sum(c(150,1250,460))

plot.data <- cbind(
c(dim(stage1.utr5)[1],dim(stage1.cds)[1],dim(stage1.utr3)[1]),
c(dim(stage2.utr5)[1],dim(stage2.cds)[1],dim(stage2.utr3)[1]),
c(dim(stage3.utr5)[1],dim(stage3.cds)[1],dim(stage3.utr3)[1]),
c(dim(stage4.utr5)[1],dim(stage4.cds)[1],dim(stage4.utr3)[1]),
c(dim(stage5.utr5)[1],dim(stage5.cds)[1],dim(stage5.utr3)[1]))


utr5.res <- c()
cds.res <- c()
utr3.res <- c()
for(i in 1:ncol(plot.data)){
	utr5.expected <- sum(plot.data[,i])*ratio[1]
	cds.expected <- sum(plot.data[,i])*ratio[2]
	utr3.expected <- sum(plot.data[,i])*ratio[3]

	utr5.enrich <- plot.data[1,i]/utr5.expected
	cds.enrich <- plot.data[2,i]/cds.expected
	utr3.enrich <- plot.data[3,i]/utr3.expected
	utr5.res <- c(utr5.res, utr5.enrich)
	cds.res <- c(cds.res, cds.enrich)
	utr3.res <- c(utr3.res, utr3.enrich)	
}

pdf(paste(output,"-enrich.pdf",sep=""), width=10)
barplot(cbind(utr5.res, cds.res, utr3.res),beside=T, col=c("#1391BF","#066191","#13315D","#F09495","#EA6363"), yaxt='n',xaxt="n", ylab="", xlab="", main="",space=c(0.2, 1.4), ylim=c(0, 4))
abline(h=0, lwd=3)
axis(2,at=seq(0,4,1), labels=rep("",5), tcl=-1.3, lwd=3, las=2)
dev.off()


