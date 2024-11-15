## GEOSPATIAL DATA SCIENCE WITH JULIA

using GeoStats
using GeoIO

import Unitful: km, K

import GLMakie as Mke

## 1. Loading meteorological data

meteo = GeoIO.load("data/meteo.csv", coords = ("LAT", "LON")) |>
        DropMissing() |> Unitify() |> Rename("T" => "temperature")

meteo |> viewer

## 2. Projecting data to Euclidean space

projected = meteo |> Proj(Robinson)

projected |> viewer

## 3. Transforming values to normal scores

transform = Unit(K) → Detrend() → Quantile()

normalized, cache = apply(transform, projected)

normalized |> viewer

## 4. Fitting variogram/covariance model

maxlag = 1500km

g = EmpiricalVariogram(normalized, "temperature", estimator = :cressie, maxlag = maxlag, nlags = 10)
γ = GeoStatsFunctions.fit(SphericalVariogram, g)

varioplot(g)
varioplot!(γ, maxlag = maxlag, color = "teal")
Mke.current_figure()

## 5. Defining grid for interpolation

bbox = boundingbox(normalized.geometry)
grid = RegularGrid(minimum(bbox), maximum(bbox), (20km, 20km))

## 6. Kriging interpolation

model = Kriging(γ)

interpolated = normalized |> Interpolate(grid, model)

interpolated |> viewer

## 7. Reverting from normal scores

reverted = revert(transform, interpolated, cache)

reverted |> viewer

## 8. Reprojecting to Earth's ellipsoid

final = reverted |> Proj(LatLon)

final |> viewer

## 9. Loading base map for visualization

earth = GeoIO.load("data/earth.tif")

earth |> viewer

## 10. Interactive 3D visualization

viztransform = Rotate(RotZ(π/2)) → Rotate((1, 1, 0), (1, 1, 1))

fig = Mke.Figure()
viz(fig[1,1],  earth.geometry |> viztransform, color = earth.color)
viz!(fig[1,1], final.geometry |> viztransform, color = final.temperature)
viz!(fig[1,1], meteo.geometry |> viztransform, color = "red")
cbar(fig[1,2], final.temperature)
fig
