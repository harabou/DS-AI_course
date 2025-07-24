#####MICEのインストール#####
install.packages("mice")
library(mice)

#####VIMのインストール#####
install.packages("VIM")
library(VIM)

#####Dataset読み込み（EZRでの操作）#####
Dataset <- readXL("C:/Users/ahara/Desktop/hsb_mar.xlsx", rownames=FALSE, 
  header=TRUE, na="", sheet="hsb_mar", stringsAsFactors=TRUE)

#####データセット内の変数を一覧する#####
str(Dataset)

#####連続変数を因子に変換する#####
Dataset$FEMALEX <- as.factor(Dataset$FEMALE)
Dataset$PROGX <- as.factor(Dataset$PROG)
Dataset$RACEX <- as.factor(Dataset$RACE)
Dataset$SCHTYPX <- as.factor(Dataset$SCHTYP)
Dataset$SESX <- as.factor(Dataset$SES)

#####データセット内の変数を一覧する#####
str(Dataset)

md.pattern(Dataset, rotate.names=TRUE)
aggr(Dataset)





#####Dry run#####

ini <- mice(Dataset, maxit=0)
ini$method
ini$predictorMatrix
ini$visitSequence

#####代入使用　最適な変数の選択（quickpred ）#####
quickpred(Dataset, mincor = 0.1, minpuc=0.25)

ini <- mice(Dataset, maxit=0)
meth <- ini$method

imp <- mice(Dataset, method=meth)
meth <- ini$method
seq <- ini$visitSequence

#####（quickpred ）で得られたマトリクスを使用するための処理#####
pred <- quickpred(Dataset, mincor = 0.1, minpuc=0.25)
pred

imp <- mice(Dataset, maxit=20,
            method = meth, 
            predictorMatrix = pred, 
            visitSequence = seq, seed=1)


#####代入データセットを使用したモデリング#####
fit <- with(imp, lm(READ ~ FEMALEX+WRITE + MATH　+ PROGX　+ WRITE))

#####統合作業#####
est <- pool(fit)

#####統合結果表示#####
est


#補完の1つ目のデータセットを見てみる
complete(imp,1)

＃収束状況の確認
plot(imp)
summary(complete(imp, action="long"))
densityplot(imp)



