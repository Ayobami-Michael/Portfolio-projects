
select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

--select data to be used

select Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

--some simple explorations
--Looking at Total cases vs Total deaths
--this data shows the likelihood of a person in Africa dying if they contract the virus

select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
from PortfolioProject..CovidDeaths
where Location = 'Africa'

--looking at Total cases vs Population
--shows what % of population got the virus

select Location, date, population, total_cases,(total_cases/population)*100 AS InfectedPopulationPercentage
from PortfolioProject..CovidDeaths
where Location='Africa'
order by 1,2

--looking at countries with Highest Infection Rate compared to Population

select Location, population,  MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 AS InfectedPopulationPercentage
from PortfolioProject..CovidDeaths
--where Location='Africa'
group by  continent, population
order by InfectedPopulationPercentage DESC


--showing countries with Highest Death count per Population

select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where Location='Africa'
where continent is not null
group by  continent
order by TotalDeathCount DESC

--breaking things down

select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where Location='Africa'
where continent is  null
group by location
order by TotalDeathCount DESC

--showing continents with highest death counts

select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where Location='Africa'
where continent is not null
group by continent
order by TotalDeathCount DESC

--GLOBAL DEATHS(TOTAL)

select SUM(new_cases)as total_cases,SUM(cast(new_deaths as int)) as total_deaths,
      SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2

--Global cases and deaths per day

select date,SUM(new_cases)as total_cases,SUM(cast(new_deaths as int)) as total_deaths,
      SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
group by date
order by 1,2



