
import pandas as pd
import polars as pl
import tqdm
import numpy as np

import pyspark.sql.functions as F
import pyspark.sql.types as T
import pyspark.sql.window as W
from pyspark.sql.dataframe import DataFrame
from pyspark.sql.session import SparkSession
spark = SparkSession.builder.getOrCreate()

pdf = pd.read_csv("~/dotfiles/dev/data/homes.csv")

schema = T.StructType([
    T.StructField("rowid", T.IntegerType()),
    T.StructField("owner_name", T.StringType()),
    T.StructField("area", T.StringType()),
    T.StructField("value", T.IntegerType())
])

df = (
    spark.read
    .option("header", True)
    .option("schema", schema)
    .csv("/home/moz/dotfiles/dev/data/homes.csv")
)
df.show(2)


