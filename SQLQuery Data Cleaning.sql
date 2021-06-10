--Showing some SQL Data-Cleaning skills

  select *
  FROM PortfolioProject.dbo.NashvilleHousing


--standardizing Date Format

updatePortfolioProject.dbo.NashvilleHousing
set SaleDate=CONVERT(Date,SaleDate)

ALTER table NashvilleHousing
ADD SaleDateConverted Date;

update PortfolioProject.dbo.NashvilleHousing
set SaleDateConverted = Convert(Date,SaleDate)

Select SaleDateConverted                         
FROM PortfolioProject.dbo.NashvilleHousing


--Populate PropertyAddress column to remove NULLS
--done by joining the table by itself

Select PropertyAddress                        
FROM PortfolioProject.dbo.NashvilleHousing
where PropertyAddress is null

Update a 
SET PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID =b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is null


--Breaking Out "PropertyAddress" column into individual columns(Address,City,State)

Select PropertyAddress        
FROM PortfolioProject.dbo.NashvilleHousing

SELECT
SUBSTRING(PropertyAddress,1,CHARINDEX(',', PropertyAddress)-1) as Address              -- 1 as in index of first letter(no index 0 in sql)  , ',' as in delimeter in the column,-1 removes the ',' from showing
, SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as City     -- "+1" gets rid of the , index

FROM PortfolioProject.dbo.NashvilleHousing

--adding the new columns to the table
--Address
ALTER table PortfolioProject.dbo.NashvilleHousing
ADD Address NVARCHAR(255);

update PortfolioProject.dbo.NashvilleHousing
set Address = SUBSTRING(PropertyAddress,1,CHARINDEX(',', PropertyAddress)-1)

--City
ALTER table PortfolioProject.dbo.NashvilleHousing
ADD City NVARCHAR(255);

updatePortfolioProject.dbo.NashvilleHousing
set City=SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

--State
--ALTER table NashvilleHousing
--ADD State NVARCHAR(255);

--update NashvilleHousing=

-- Breaking out the "OwnerAddress" column with another method that's not SUBSTRING
--the "PARSENAME" function
--it uses a period i.e "." instead of a comma
--it displays results of a column from the back and so you have to specify that the 3rd item of the column is 1,2nd =2 and 1st=3
--better than the SUBSTRING method
select OwnerAddress
FROM PortfolioProject.dbo.NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress,',','.'), 3),
PARSENAME(REPLACE(OwnerAddress,',','.'), 2),
PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
FROM PortfolioProject.dbo.NashvilleHousing




--adding the columns to the table

ALTER table PortfolioProject.dbo.NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255);

update PortfolioProject.dbo.NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

--City
ALTER table PortfolioProject.dbo.NashvilleHousing
ADD OwnerSplitCity NVARCHAR(255);

update PortfolioProject.dbo.NashvilleHousing
set OwnerSplitCity=PARSENAME(REPLACE(OwnerAddress,',','.'), 2)
--State
ALTER table PortfolioProject.dbo.NashvilleHousing
ADD OwnerSplitState NVARCHAR(255);

update PortfolioProject.dbo.NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)





--change the N and Y in the "Sold as vacant' column to YES and NO

select SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant ='N' THEN 'No'
	 ELSE SoldAsVacant
	 END
	FROM PortfolioProject.dbo.NashvilleHousing

--updating the table

UPDATE  PortfolioProject.dbo.NashvilleHousing
SET SoldAsVacant=CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant ='N' THEN 'No'
	 ELSE SoldAsVacant
	 END



-- Removing Duplicates






--Deleting cleaned columns

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress,PropertyAddress,SaleDate


