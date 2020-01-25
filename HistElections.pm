package HistElections;
use strict;
use FindBin;
use Exporter qw(import);
our @EXPORT_OK = qw(get_histvalues);

sub get_histvalues {
  my %histvals = {
    'AK' => {
      2020 => 3,
      2016 => 3,
      2012 => 3,
      2008 => 3,
      2004 => 3,
      2000 => 3,
      1996 => 3,
      1992 => 3,
      1988 => 3,
      1984 => 3,
      1980 => 3,
      1976 => 3,
      1972 => 3,
      1968 => 3,
      1964 => 3,
      1960 => 3
    },
    'AL' => {
      2020 => 9,
      2016 => 9,
      2012 => 9,
      2008 => 9,
      2004 => 9,
      2000 => 9,
      1996 => 9,
      1992 => 9,
      1988 => 9,
      1984 => 9,
      1980 => 9,
      1976 => 9,
      1972 => 9,
      1968 => 10,
      1964 => 10,
      1960 => 11,
      1956 => 11,
      1952 => 11,
      1948 => 11,
      1944 => 11,
      1940 => 11,
      1936 => 11,
      1932 => 11,
      1928 => 12,
      1924 => 12,
      1920 => 12,
      1916 => 12,
      1912 => 12,
      1908 => 11,
      1904 => 11,
      1900 => 11,
      1896 => 11,
      1892 => 11,
      1888 => 10,
      1884 => 10,
      1880 => 10,
      1876 => 10,
      1872 => 10,
      1868 => 8,
      1860 => 9,
      1856 => 9,
      1852 => 9,
      1848 => 9,
      1844 => 9,
      1840 => 7,
      1836 => 7,
      1832 => 7,
      1828 => 5,
      1824 => 5,
      1820 => 3
    },
    'AR' => {
      2020 => 6,
      2016 => 6,
      2012 => 6,
      2008 => 6,
      2004 => 6,
      2000 => 6,
      1996 => 6,
      1992 => 6,
      1988 => 6,
      1984 => 6,
      1980 => 6,
      1976 => 6,
      1972 => 6,
      1968 => 6,
      1964 => 6,
      1960 => 8,
      1956 => 8,
      1952 => 8,
      1948 => 9,
      1944 => 9,
      1940 => 9,
      1936 => 9,
      1932 => 9,
      1928 => 9,
      1924 => 9,
      1920 => 9,
      1916 => 9,
      1912 => 9,
      1908 => 9,
      1904 => 9,
      1900 => 8,
      1896 => 8,
      1892 => 8,
      1888 => 7,
      1884 => 7,
      1880 => 6,
      1876 => 6,
      1872 => 6,
      1868 => 5,
      1860 => 4,
      1856 => 4,
      1852 => 4,
      1848 => 3,
      1844 => 3,
      1840 => 3,
      1836 => 3,
    },
    'AZ' => {
      2020 => 11,
      2016 => 11,
      2012 => 11,
      2008 => 10,
      2004 => 10,
      2000 => 8,
      1996 => 8,
      1992 => 8,
      1988 => 7,
      1984 => 7,
      1980 => 6,
      1976 => 6,
      1972 => 6,
      1968 => 5,
      1964 => 5,
      1960 => 4,
      1956 => 4,
      1952 => 4,
      1948 => 4,
      1944 => 4,
      1940 => 3,
      1936 => 3,
      1932 => 3,
      1928 => 3,
      1924 => 3,
      1920 => 3,
      1916 => 3,
      1912 => 3
    },
    'CA' => {
      2020 => 55,
      2016 => 55,
      2012 => 55,
      2008 => 55,
      2004 => 55,
      2000 => 54,
      1996 => 54,
      1992 => 54,
      1988 => 47,
      1984 => 47,
      1980 => 45,
      1976 => 45,
      1972 => 45,
      1968 => 40,
      1964 => 40,
      1960 => 32,
      1956 => 32,
      1952 => 32,
      1948 => 25,
      1944 => 25,
      1940 => 22,
      1936 => 22,
      1932 => 22,
      1928 => 13,
      1924 => 13,
      1920 => 13,
      1916 => 13,
      1912 => 13,
      1908 => 10,
      1904 => 10,
      1900 => 9,
      1896 => 9,
      1892 => 9,
      1888 => 8,
      1884 => 8,
      1880 => 6,
      1876 => 6,
      1872 => 6,
      1868 => 5,
      1864 => 5,
      1860 => 4,
      1856 => 4,
      1852 => 4
    },
    'CO' => {
      2020 => 9,
      2016 => 9,
      2012 => 9,
      2008 => 9,
      2004 => 9,
      2000 => 8,
      1996 => 8,
      1992 => 8,
      1988 => 8,
      1984 => 8,
      1980 => 7,
      1976 => 7,
      1972 => 7,
      1968 => 6,
      1964 => 6,
      1960 => 6,
      1956 => 6,
      1952 => 6,
      1948 => 6,
      1944 => 6,
      1940 => 6,
      1936 => 6,
      1932 => 6,
      1928 => 6,
      1924 => 6,
      1920 => 6,
      1916 => 6,
      1912 => 6,
      1908 => 5,
      1904 => 5,
      1900 => 4,
      1896 => 4,
      1892 => 4,
      1888 => 3,
      1884 => 3,
      1880 => 3,
      1876 => 3
    },
    'CT' => {
      2020 => 7,
      2016 => 7,
      2012 => 7,
      2008 => 7,
      2004 => 7,
      2000 => 8,
      1996 => 8,
      1992 => 8,
      1988 => 8,
      1984 => 8,
      1980 => 8,
      1976 => 8,
      1972 => 8,
      1968 => 8,
      1964 => 8,
      1960 => 8,
      1956 => 8,
      1952 => 8,
      1948 => 8,
      1944 => 8,
      1940 => 8,
      1936 => 8,
      1932 => 8,
      1928 => 7,
      1924 => 7,
      1920 => 7,
      1916 => 7,
      1912 => 7,
      1908 => 7,
      1904 => 7,
      1900 => 6,
      1896 => 6,
      1892 => 6,
      1888 => 6,
      1884 => 6,
      1880 => 6,
      1876 => 6,
      1872 => 6,
      1868 => 6,
      1864 => 6,
      1860 => 6,
      1856 => 6,
      1852 => 6,
      1848 => 6,
      1844 => 6,
      1840 => 8,
      1836 => 8,
      1832 => 8,
      1828 => 8,
      1824 => 8,
      1820 => 9,
      1816 => 9,
      1812 => 9,
      1808 => 9,
      1804 => 9,
      1800 => 9,
      1796 => 9,
      1792 => 9,
      1788 => 7
    },
    'DC' => {
      2020 => 3,
      2016 => 3,
      2012 => 3,
      2008 => 3,
      2004 => 3,
      2000 => 3,
      1996 => 3,
      1992 => 3,
      1988 => 3,
      1984 => 3,
      1980 => 3,
      1976 => 3,
      1972 => 3,
      1968 => 3,
      1964 => 3
    },
    'DE' => {
      2020 => 3,
      2016 => 3,
      2012 => 3,
      2008 => 3,
      2004 => 3,
      2000 => 3,
      1996 => 3,
      1992 => 3,
      1988 => 3,
      1984 => 3,
      1980 => 3,
      1976 => 3,
      1972 => 3,
      1968 => 3,
      1964 => 3,
      1960 => 3,
      1956 => 3,
      1952 => 3,
      1948 => 3,
      1944 => 3,
      1940 => 3,
      1936 => 3,
      1932 => 3,
      1928 => 3,
      1924 => 3,
      1920 => 3,
      1916 => 3,
      1912 => 3,
      1908 => 3,
      1904 => 3,
      1900 => 3,
      1896 => 3,
      1892 => 3,
      1888 => 3,
      1884 => 3,
      1880 => 3,
      1876 => 3,
      1872 => 3,
      1868 => 3,
      1864 => 3,
      1860 => 3,
      1856 => 3,
      1852 => 3,
      1848 => 3,
      1844 => 3,
      1840 => 3,
      1836 => 3,
      1832 => 3,
      1828 => 3,
      1824 => 3,
      1820 => 4,
      1816 => 4,
      1812 => 4,
      1808 => 3,
      1804 => 3,
      1800 => 3,
      1796 => 3,
      1792 => 3,
      1788 => 3
    },
    'FL' => {
      2020 => 29,
      2016 => 29,
      2012 => 29,
      2008 => 27,
      2004 => 27,
      2000 => 25,
      1996 => 25,
      1992 => 25,
      1988 => 21,
      1984 => 21,
      1980 => 17,
      1976 => 17,
      1972 => 17,
      1968 => 14,
      1964 => 14,
      1960 => 10,
      1956 => 10,
      1952 => 10,
      1948 => 8,
      1944 => 8,
      1940 => 7,
      1936 => 7,
      1932 => 7,
      1928 => 6,
      1924 => 6,
      1920 => 6,
      1916 => 6,
      1912 => 6,
      1908 => 5,
      1904 => 5,
      1900 => 4,
      1896 => 4,
      1892 => 4,
      1888 => 4,
      1884 => 4,
      1880 => 4,
      1876 => 4,
      1872 => 4,
      1868 => 3,
      1860 => 3,
      1856 => 3,
      1852 => 3,
      1848 => 3
    },
    'GA' => {
      2020 => 16,
      2016 => 16,
      2012 => 16,
      2008 => 15,
      2004 => 15,
      2000 => 13,
      1996 => 13,
      1992 => 13,
      1988 => 12,
      1984 => 12,
      1980 => 12,
      1976 => 12,
      1972 => 12,
      1968 => 12,
      1964 => 12,
      1960 => 12,
      1956 => 12,
      1952 => 12,
      1948 => 12,
      1944 => 12,
      1940 => 12,
      1936 => 12,
      1932 => 12,
      1928 => 14,
      1924 => 14,
      1920 => 14,
      1916 => 14,
      1912 => 14,
      1908 => 13,
      1904 => 13,
      1900 => 13,
      1896 => 13,
      1892 => 13,
      1888 => 12,
      1884 => 12,
      1880 => 11,
      1876 => 11,
      1872 => 11,
      1868 => 9,
      1860 => 10,
      1856 => 10,
      1852 => 10,
      1848 => 10,
      1844 => 10,
      1840 => 11,
      1836 => 11,
      1832 => 11,
      1828 => 9,
      1824 => 9,
      1820 => 8,
      1816 => 8,
      1812 => 8,
      1808 => 6,
      1804 => 6,
      1800 => 4,
      1796 => 4,
      1792 => 4,
      1788 => 5
    },
    'HI' => {
      2020 => 4,
      2016 => 4,
      2012 => 4,
      2008 => 4,
      2004 => 4,
      2000 => 4,
      1996 => 4,
      1992 => 4,
      1988 => 4,
      1984 => 4,
      1980 => 4,
      1976 => 4,
      1972 => 4,
      1968 => 4,
      1964 => 4,
      1960 => 3
    },
    'IA' => {
      2020 => 6,
      2016 => 6,
      2012 => 6,
      2008 => 7,
      2004 => 7,
      2000 => 7,
      1996 => 7,
      1992 => 7,
      1988 => 8,
      1984 => 8,
      1980 => 8,
      1976 => 8,
      1972 => 8,
      1968 => 9,
      1964 => 9,
      1960 => 10,
      1956 => 10,
      1952 => 10,
      1948 => 10,
      1944 => 10,
      1940 => 11,
      1936 => 11,
      1932 => 11,
      1928 => 13,
      1924 => 13,
      1920 => 13,
      1916 => 13,
      1912 => 13,
      1908 => 13,
      1904 => 13,
      1900 => 13,
      1896 => 13,
      1892 => 13,
      1888 => 13,
      1884 => 13,
      1880 => 11,
      1876 => 11,
      1872 => 11,
      1868 => 8,
      1864 => 8,
      1860 => 4,
      1856 => 4,
      1852 => 4,
      1848 => 4
    },
    'ID' => {
      2020 => 4,
      2016 => 4,
      2012 => 4,
      2008 => 4,
      2004 => 4,
      2000 => 4,
      1996 => 4,
      1992 => 4,
      1988 => 4,
      1984 => 4,
      1980 => 4,
      1976 => 4,
      1972 => 4,
      1968 => 4,
      1964 => 4,
      1960 => 4,
      1956 => 4,
      1952 => 4,
      1948 => 4,
      1944 => 4,
      1940 => 4,
      1936 => 4,
      1932 => 4,
      1928 => 4,
      1924 => 4,
      1920 => 4,
      1916 => 4,
      1912 => 4,
      1908 => 3,
      1904 => 3,
      1900 => 3,
      1896 => 3,
      1892 => 3
    },
    'IL' => {
      2020 => 20,
      2016 => 20,
      2012 => 20,
      2008 => 21,
      2004 => 21,
      2000 => 22,
      1996 => 22,
      1992 => 22,
      1988 => 24,
      1984 => 24,
      1980 => 26,
      1976 => 26,
      1972 => 26,
      1968 => 26,
      1964 => 26,
      1960 => 27,
      1956 => 27,
      1952 => 27,
      1948 => 28,
      1944 => 28,
      1940 => 29,
      1936 => 29,
      1932 => 29,
      1928 => 29,
      1924 => 29,
      1920 => 29,
      1916 => 29,
      1912 => 29,
      1908 => 27,
      1904 => 27,
      1900 => 24,
      1896 => 24,
      1892 => 24,
      1888 => 22,
      1884 => 22,
      1880 => 21,
      1876 => 21,
      1872 => 21,
      1868 => 16,
      1864 => 16,
      1860 => 11,
      1856 => 11,
      1852 => 11,
      1848 => 9,
      1844 => 9,
      1840 => 5,
      1836 => 5,
      1832 => 5,
      1828 => 3,
      1824 => 3,
      1820 => 3
    },
    'IN' => {
      2020 => 11,
      2016 => 11,
      2012 => 11,
      2008 => 11,
      2004 => 11,
      2000 => 12,
      1996 => 12,
      1992 => 12,
      1988 => 12,
      1984 => 12,
      1980 => 13,
      1976 => 13,
      1972 => 13,
      1968 => 13,
      1964 => 13,
      1960 => 13,
      1956 => 13,
      1952 => 13,
      1948 => 13,
      1944 => 13,
      1940 => 14,
      1936 => 14,
      1932 => 14,
      1928 => 15,
      1924 => 15,
      1920 => 15,
      1916 => 15,
      1912 => 15,
      1908 => 15,
      1904 => 15,
      1900 => 15,
      1896 => 15,
      1892 => 15,
      1888 => 15,
      1884 => 15,
      1880 => 15,
      1876 => 15,
      1872 => 15,
      1868 => 13,
      1864 => 13,
      1860 => 13,
      1856 => 13,
      1852 => 13,
      1848 => 12,
      1844 => 12,
      1840 => 9,
      1836 => 9,
      1832 => 9,
      1828 => 5,
      1824 => 5,
      1820 => 3,
      1816 => 3
    },
    'KS' => {
      2020 => 6,
      2016 => 6,
      2012 => 6,
      2008 => 6,
      2004 => 6,
      2000 => 6,
      1996 => 6,
      1992 => 6,
      1988 => 7,
      1984 => 7,
      1980 => 7,
      1976 => 7,
      1972 => 7,
      1968 => 7,
      1964 => 7,
      1960 => 8,
      1956 => 8,
      1952 => 8,
      1948 => 8,
      1944 => 8,
      1940 => 9,
      1936 => 9,
      1932 => 9,
      1928 => 10,
      1924 => 10,
      1920 => 10,
      1916 => 10,
      1912 => 10,
      1908 => 10,
      1904 => 10,
      1900 => 10,
      1896 => 10,
      1892 => 10,
      1888 => 9,
      1884 => 9,
      1880 => 5,
      1876 => 5,
      1872 => 5,
      1868 => 3,
      1864 => 3
    },
    'KY' => {
      2020 => 8,
      2016 => 8,
      2012 => 8,
      2008 => 8,
      2004 => 8,
      2000 => 8,
      1996 => 8,
      1992 => 8,
      1988 => 9,
      1984 => 9,
      1980 => 9,
      1976 => 9,
      1972 => 9,
      1968 => 9,
      1964 => 9,
      1960 => 10,
      1956 => 10,
      1952 => 10,
      1948 => 11,
      1944 => 11,
      1940 => 11,
      1936 => 11,
      1932 => 11,
      1928 => 13,
      1924 => 13,
      1920 => 13,
      1916 => 13,
      1912 => 13,
      1908 => 13,
      1904 => 13,
      1900 => 13,
      1896 => 13,
      1892 => 13,
      1888 => 13,
      1884 => 13,
      1880 => 12,
      1876 => 12,
      1872 => 12,
      1868 => 11,
      1864 => 11,
      1860 => 12,
      1856 => 12,
      1852 => 12,
      1848 => 12,
      1844 => 12,
      1840 => 15,
      1836 => 15,
      1832 => 15,
      1828 => 14,
      1824 => 14,
      1820 => 12,
      1816 => 12,
      1812 => 12,
      1808 => 8,
      1804 => 8,
      1800 => 4,
      1796 => 4,
      1792 => 4
    },
    'LA' => {
      2020 => 8,
      2016 => 8,
      2012 => 8,
      2008 => 9,
      2004 => 9,
      2000 => 9,
      1996 => 9,
      1992 => 9,
      1988 => 10,
      1984 => 10,
      1980 => 10,
      1976 => 10,
      1972 => 10,
      1968 => 10,
      1964 => 10,
      1960 => 10,
      1956 => 10,
      1952 => 10,
      1948 => 10,
      1944 => 10,
      1940 => 10,
      1936 => 10,
      1932 => 10,
      1928 => 10,
      1924 => 10,
      1920 => 10,
      1916 => 10,
      1912 => 10,
      1908 => 9,
      1904 => 9,
      1900 => 8,
      1896 => 8,
      1892 => 8,
      1888 => 8,
      1884 => 8,
      1880 => 8,
      1876 => 8,
      1872 => 8,
      1868 => 7,
      1860 => 6,
      1856 => 6,
      1852 => 6,
      1848 => 6,
      1844 => 6,
      1840 => 5,
      1836 => 5,
      1832 => 5,
      1828 => 5,
      1824 => 5,
      1820 => 3,
      1816 => 3,
      1812 => 3
    },
    'MA' => {
      2020 => 11,
      2016 => 11,
      2012 => 11,
      2008 => 12,
      2004 => 12,
      2000 => 12,
      1996 => 12,
      1992 => 12,
      1988 => 13,
      1984 => 13,
      1980 => 14,
      1976 => 14,
      1972 => 14,
      1968 => 14,
      1964 => 14,
      1960 => 16,
      1956 => 16,
      1952 => 16,
      1948 => 16,
      1944 => 16,
      1940 => 17,
      1936 => 17,
      1932 => 17,
      1928 => 18,
      1924 => 18,
      1920 => 18,
      1916 => 18,
      1912 => 18,
      1908 => 16,
      1904 => 16,
      1900 => 15,
      1896 => 15,
      1892 => 15,
      1888 => 14,
      1884 => 14,
      1880 => 13,
      1876 => 13,
      1872 => 13,
      1868 => 12,
      1864 => 12,
      1860 => 13,
      1856 => 13,
      1852 => 13,
      1848 => 12,
      1844 => 12,
      1840 => 14,
      1836 => 14,
      1832 => 14,
      1828 => 15,
      1824 => 15,
      1820 => 15,
      1816 => 22,
      1812 => 22,
      1808 => 19,
      1804 => 19,
      1800 => 16,
      1796 => 16,
      1792 => 16,
      1788 => 10
    },
    'MD' => {
      2020 => 10,
      2016 => 10,
      2012 => 10,
      2008 => 10,
      2004 => 10,
      2000 => 10,
      1996 => 10,
      1992 => 10,
      1988 => 10,
      1984 => 10,
      1980 => 10,
      1976 => 10,
      1972 => 10,
      1968 => 10,
      1964 => 10,
      1960 => 9,
      1956 => 9,
      1952 => 9,
      1948 => 8,
      1944 => 8,
      1940 => 8,
      1936 => 8,
      1932 => 8,
      1928 => 8,
      1924 => 8,
      1920 => 8,
      1916 => 8,
      1912 => 8,
      1908 => 8,
      1904 => 8,
      1900 => 8,
      1896 => 8,
      1892 => 8,
      1888 => 8,
      1884 => 8,
      1880 => 8,
      1876 => 8,
      1872 => 8,
      1868 => 7,
      1864 => 7,
      1860 => 8,
      1856 => 8,
      1852 => 8,
      1848 => 8,
      1844 => 8,
      1840 => 10,
      1836 => 10,
      1832 => 10,
      1828 => 11,
      1824 => 11,
      1820 => 11,
      1816 => 11,
      1812 => 11,
      1808 => 11,
      1804 => 11,
      1800 => 10,
      1796 => 10,
      1792 => 10,
      1788 => 8
    },
    'ME' => {
      2020 => 2,
      2016 => 2,
      2012 => 2,
      2008 => 2,
      2004 => 2,
      2000 => 2,
      1996 => 2,
      1992 => 2,
      1988 => 2,
      1984 => 2,
      1980 => 2,
      1976 => 2,
      1972 => 2,
      1968 => 4,
      1964 => 4,
      1960 => 5,
      1956 => 5,
      1952 => 5,
      1948 => 5,
      1944 => 5,
      1940 => 5,
      1936 => 5,
      1932 => 5,
      1928 => 6,
      1924 => 6,
      1920 => 6,
      1916 => 6,
      1912 => 6,
      1908 => 6,
      1904 => 6,
      1900 => 6,
      1896 => 6,
      1892 => 6,
      1888 => 6,
      1884 => 6,
      1880 => 7,
      1876 => 7,
      1872 => 7,
      1868 => 7,
      1864 => 7,
      1860 => 8,
      1856 => 8,
      1852 => 8,
      1848 => 9,
      1844 => 9,
      1840 => 10,
      1836 => 10,
      1832 => 10,
      1828 => 9,
      1824 => 9,
      1820 => 9
    },
    'ME1' => {
      2020 => 1,
      2016 => 1,
      2012 => 1,
      2008 => 1,
      2004 => 1,
      2000 => 1,
      1996 => 1,
      1992 => 1,
      1988 => 1,
      1984 => 1,
      1980 => 1,
      1976 => 1,
      1972 => 1
    },
    'ME2' => {
      2020 => 1,
      2016 => 1,
      2012 => 1,
      2008 => 1,
      2004 => 1,
      2000 => 1,
      1996 => 1,
      1992 => 1,
      1988 => 1,
      1984 => 1,
      1980 => 1,
      1976 => 1,
      1972 => 1
    },
    'MI' => {
      2020 => 16,
      2016 => 16,
      2012 => 16,
      2008 => 17,
      2004 => 17,
      2000 => 18,
      1996 => 18,
      1992 => 18,
      1988 => 20,
      1984 => 20,
      1980 => 21,
      1976 => 21,
      1972 => 21,
      1968 => 21,
      1964 => 21,
      1960 => 20,
      1956 => 20,
      1952 => 20,
      1948 => 19,
      1944 => 19,
      1940 => 19,
      1936 => 19,
      1932 => 19,
      1928 => 15,
      1924 => 15,
      1920 => 15,
      1916 => 15,
      1912 => 15,
      1908 => 14,
      1904 => 14,
      1900 => 14,
      1896 => 14,
      1892 => 14,
      1888 => 13,
      1884 => 13,
      1880 => 11,
      1876 => 11,
      1872 => 11,
      1868 => 8,
      1864 => 8,
      1860 => 6,
      1856 => 6,
      1852 => 6,
      1848 => 5,
      1844 => 5,
      1840 => 3,
      1836 => 3
    },
    'MN' => {
      2020 => 10,
      2016 => 10,
      2012 => 10,
      2008 => 10,
      2004 => 10,
      2000 => 10,
      1996 => 10,
      1992 => 10,
      1988 => 10,
      1984 => 10,
      1980 => 10,
      1976 => 10,
      1972 => 10,
      1968 => 10,
      1964 => 10,
      1960 => 11,
      1956 => 11,
      1952 => 11,
      1948 => 11,
      1944 => 11,
      1940 => 11,
      1936 => 11,
      1932 => 11,
      1928 => 12,
      1924 => 12,
      1920 => 12,
      1916 => 12,
      1912 => 12,
      1908 => 11,
      1904 => 11,
      1900 => 9,
      1896 => 9,
      1892 => 9,
      1888 => 7,
      1884 => 7,
      1880 => 5,
      1876 => 5,
      1872 => 5,
      1868 => 4,
      1864 => 4,
      1860 => 4
    },
    'MO' => {
      2020 => 10,
      2016 => 10,
      2012 => 10,
      2008 => 11,
      2004 => 11,
      2000 => 11,
      1996 => 11,
      1992 => 11,
      1988 => 11,
      1984 => 11,
      1980 => 12,
      1976 => 12,
      1972 => 12,
      1968 => 12,
      1964 => 12,
      1960 => 13,
      1956 => 13,
      1952 => 13,
      1948 => 15,
      1944 => 15,
      1940 => 15,
      1936 => 15,
      1932 => 15,
      1928 => 18,
      1924 => 18,
      1920 => 18,
      1916 => 18,
      1912 => 18,
      1908 => 18,
      1904 => 18,
      1900 => 17,
      1896 => 17,
      1892 => 17,
      1888 => 16,
      1884 => 16,
      1880 => 15,
      1876 => 15,
      1872 => 15,
      1868 => 11,
      1864 => 11,
      1860 => 9,
      1856 => 9,
      1852 => 9,
      1848 => 7,
      1844 => 7,
      1840 => 4,
      1836 => 4,
      1832 => 4,
      1828 => 3,
      1824 => 3,
      1820 => 3
    },
    'MS' => {
      2020 => 6,
      2016 => 6,
      2012 => 6,
      2008 => 6,
      2004 => 6,
      2000 => 7,
      1996 => 7,
      1992 => 7,
      1988 => 7,
      1984 => 7,
      1980 => 7,
      1976 => 7,
      1972 => 7,
      1968 => 7,
      1964 => 7,
      1960 => 8,
      1956 => 8,
      1952 => 8,
      1948 => 9,
      1944 => 9,
      1940 => 9,
      1936 => 9,
      1932 => 9,
      1928 => 10,
      1924 => 10,
      1920 => 10,
      1916 => 10,
      1912 => 10,
      1908 => 10,
      1904 => 10,
      1900 => 9,
      1896 => 9,
      1892 => 9,
      1888 => 9,
      1884 => 9,
      1880 => 8,
      1876 => 8,
      1872 => 8,
      1860 => 7,
      1856 => 7,
      1852 => 7,
      1848 => 6,
      1844 => 6,
      1840 => 4,
      1836 => 4,
      1832 => 4,
      1828 => 3,
      1824 => 3,
      1820 => 3
    },
    'MT' => {
      2020 => 3,
      2016 => 3,
      2012 => 3,
      2008 => 3,
      2004 => 3,
      2000 => 3,
      1996 => 3,
      1992 => 3,
      1988 => 4,
      1984 => 4,
      1980 => 4,
      1976 => 4,
      1972 => 4,
      1968 => 4,
      1964 => 4,
      1960 => 4,
      1956 => 4,
      1952 => 4,
      1948 => 4,
      1944 => 4,
      1940 => 4,
      1936 => 4,
      1932 => 4,
      1928 => 4,
      1924 => 4,
      1920 => 4,
      1916 => 4,
      1912 => 4,
      1908 => 3,
      1904 => 3,
      1900 => 3,
      1896 => 3,
      1892 => 3
    },
    'NC' => {
      2020 => 15,
      2016 => 15,
      2012 => 15,
      2008 => 15,
      2004 => 15,
      2000 => 14,
      1996 => 14,
      1992 => 14,
      1988 => 13,
      1984 => 13,
      1980 => 13,
      1976 => 13,
      1972 => 13,
      1968 => 13,
      1964 => 13,
      1960 => 14,
      1956 => 14,
      1952 => 14,
      1948 => 14,
      1944 => 14,
      1940 => 13,
      1936 => 13,
      1932 => 13,
      1928 => 12,
      1924 => 12,
      1920 => 12,
      1916 => 12,
      1912 => 12,
      1908 => 12,
      1904 => 12,
      1900 => 11,
      1896 => 11,
      1892 => 11,
      1888 => 11,
      1884 => 11,
      1880 => 10,
      1876 => 10,
      1872 => 10,
      1868 => 9,
      1860 => 10,
      1856 => 10,
      1852 => 10,
      1848 => 11,
      1844 => 11,
      1840 => 15,
      1836 => 15,
      1832 => 15,
      1828 => 15,
      1824 => 15,
      1820 => 15,
      1816 => 15,
      1812 => 15,
      1808 => 14,
      1804 => 14,
      1800 => 12,
      1796 => 12,
      1792 => 12
    },
    'ND' => {
      2020 => 3,
      2016 => 3,
      2012 => 3,
      2008 => 3,
      2004 => 3,
      2000 => 3,
      1996 => 3,
      1992 => 3,
      1988 => 3,
      1984 => 3,
      1980 => 3,
      1976 => 3,
      1972 => 3,
      1968 => 4,
      1964 => 4,
      1960 => 4,
      1956 => 4,
      1952 => 4,
      1948 => 4,
      1944 => 4,
      1940 => 4,
      1936 => 4,
      1932 => 4,
      1928 => 5,
      1924 => 5,
      1920 => 5,
      1916 => 5,
      1912 => 5,
      1908 => 4,
      1904 => 4,
      1900 => 3,
      1896 => 3,
      1892 => 3
    },
    'NE' => {
      2020 => 2,
      2016 => 2,
      2012 => 2,
      2008 => 2,
      2004 => 2,
      2000 => 2,
      1996 => 2,
      1992 => 2,
      1988 => 5,
      1984 => 5,
      1980 => 5,
      1976 => 5,
      1972 => 5,
      1968 => 5,
      1964 => 5,
      1960 => 6,
      1956 => 6,
      1952 => 6,
      1948 => 6,
      1944 => 6,
      1940 => 7,
      1936 => 7,
      1932 => 7,
      1928 => 8,
      1924 => 8,
      1920 => 8,
      1916 => 8,
      1912 => 8,
      1908 => 8,
      1904 => 8,
      1900 => 8,
      1896 => 8,
      1892 => 8,
      1888 => 5,
      1884 => 5,
      1880 => 3,
      1876 => 3,
      1872 => 3,
      1868 => 3
    },
    'NE1' => {
      2020 => 1,
      2016 => 1,
      2012 => 1,
      2008 => 1,
      2004 => 1,
      2000 => 1,
      1996 => 1,
      1992 => 1
    },
    'NE2' => {
      2020 => 1,
      2016 => 1,
      2012 => 1,
      2008 => 1,
      2004 => 1,
      2000 => 1,
      1996 => 1,
      1992 => 1
    },
    'NE3' => {
      2020 => 1,
      2016 => 1,
      2012 => 1,
      2008 => 1,
      2004 => 1,
      2000 => 1,
      1996 => 1,
      1992 => 1
    },
    'NH' => {
      2020 => 4,
      2016 => 4,
      2012 => 4,
      2008 => 4,
      2004 => 4,
      2008 => 4,
      2004 => 4,
      2000 => 4,
      1996 => 4,
      1992 => 4,
      1988 => 4,
      1994 => 4,
      1990 => 4,
      1988 => 4,
      1984 => 4,
      1980 => 4,
      1976 => 4,
      1972 => 4,
      1968 => 4,
      1964 => 4,
      1960 => 4,
      1956 => 4,
      1952 => 4,
      1948 => 4,
      1944 => 4,
      1940 => 4,
      1936 => 4,
      1932 => 4,
      1928 => 4,
      1924 => 4,
      1920 => 4,
      1916 => 4,
      1912 => 4,
      1908 => 4,
      1904 => 4,
      1900 => 4,
      1896 => 4,
      1892 => 4,
      1888 => 4,
      1884 => 4,
      1880 => 5,
      1876 => 5,
      1872 => 5,
      1868 => 5,
      1864 => 5,
      1860 => 5,
      1856 => 5,
      1852 => 5,
      1848 => 6,
      1844 => 6,
      1840 => 7,
      1836 => 7,
      1832 => 7,
      1828 => 8,
      1824 => 8,
      1820 => 8,
      1816 => 8,
      1812 => 8,
      1808 => 7,
      1804 => 7,
      1800 => 6,
      1796 => 6,
      1792 => 6,
      1788 => 5
    },
    'NJ' => {
      2020 => 14,
      2016 => 14,
      2012 => 14,
      2008 => 15,
      2004 => 15,
      2000 => 15,
      1996 => 15,
      1992 => 15,
      1988 => 16,
      1984 => 16,
      1980 => 17,
      1976 => 17,
      1972 => 17,
      1968 => 17,
      1964 => 17,
      1960 => 16,
      1956 => 16,
      1952 => 16,
      1948 => 16,
      1944 => 16,
      1940 => 16,
      1936 => 16,
      1932 => 16,
      1928 => 14,
      1924 => 14,
      1920 => 14,
      1916 => 14,
      1912 => 14,
      1908 => 12,
      1904 => 12,
      1900 => 10,
      1896 => 10,
      1892 => 10,
      1888 => 9,
      1884 => 9,
      1880 => 9,
      1876 => 9,
      1872 => 9,
      1868 => 7,
      1864 => 7,
      1860 => 7,
      1856 => 7,
      1852 => 7,
      1848 => 7,
      1844 => 7,
      1840 => 8,
      1836 => 8,
      1832 => 8,
      1828 => 8,
      1824 => 8,
      1820 => 8,
      1816 => 8,
      1812 => 8,
      1808 => 8,
      1804 => 8,
      1800 => 7,
      1796 => 7,
      1792 => 7,
      1788 => 6
    },
    'NM' => {
      2020 => 5,
      2016 => 5,
      2012 => 5,
      2008 => 5,
      2004 => 5,
      2000 => 5,
      1996 => 5,
      1992 => 5,
      1988 => 5,
      1984 => 5,
      1980 => 4,
      1976 => 4,
      1972 => 4,
      1968 => 4,
      1964 => 4,
      1960 => 4,
      1956 => 4,
      1952 => 4,
      1948 => 4,
      1944 => 4,
      1940 => 3,
      1936 => 3,
      1932 => 3,
      1928 => 3,
      1924 => 3,
      1920 => 3,
      1916 => 3,
      1912 => 3
    },
    'NV' => {
      2020 => 6,
      2016 => 6,
      2012 => 6,
      2008 => 5,
      2004 => 5,
      2000 => 4,
      1996 => 4,
      1992 => 4,
      1988 => 4,
      1984 => 4,
      1980 => 3,
      1976 => 3,
      1972 => 3,
      1968 => 3,
      1964 => 3,
      1960 => 3,
      1956 => 3,
      1952 => 3,
      1948 => 3,
      1944 => 3,
      1940 => 3,
      1936 => 3,
      1932 => 3,
      1928 => 3,
      1924 => 3,
      1920 => 3,
      1916 => 3,
      1912 => 3,
      1908 => 3,
      1904 => 3,
      1900 => 3,
      1896 => 3,
      1892 => 3,
      1888 => 3,
      1884 => 3,
      1880 => 3,
      1876 => 3,
      1872 => 3,
      1868 => 3,
      1864 => 3
    },
  };
}

1;