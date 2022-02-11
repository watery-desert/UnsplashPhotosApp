# UnsplashPhotosApp


## Features

✅ Used MVVM\
✅ Nested JSON serialization\
✅ Combine framework\
✅ Staggered grid with Pagination\
✅ handled idle, loading, loaded, error state\
✅ Search option, managed most usecases.\
✅ Download image to user device

### ⚠️ Before you run this project you need to add your accessKey.

## Don't know how to add accessKey?
 
1. Create Unsplash account
2. At the top right corner open the menu
3. Select "Developers/API" under "Product"
4. Select "Your Apps"
5. Add a new app and copy the accessKey
6. Open this project
7. Open `/UnsplashPhotosApp/Utility/ApiKeys.swift` this file 
8. Paste your accessKey there


## Screen recordings


<table>
   <tr>
      <td align="center">
         <img src="https://raw.githubusercontent.com/watery-desert/assets/main/UnsplashPhotosApp/GridView.gif" width="200"/>
      </td>
      <td align="center">
         <img align="right" src="https://raw.githubusercontent.com/watery-desert/assets/main/UnsplashPhotosApp/TopicRow.gif" width="200"/>
      </td>
   </tr>
   <tr>
      <td align="center">
         <img align="left" src="https://raw.githubusercontent.com/watery-desert/assets/main/UnsplashPhotosApp/Search.gif" width="200"/>
      </td>
      <td align="center">
         <img align="left" src="https://raw.githubusercontent.com/watery-desert/assets/main/UnsplashPhotosApp/DownloadPhoto.gif" width="200"/>
      </td>      
   </tr>
</table>


## Known issue

AsyncImage has an issue loading image 
https://developer.apple.com/forums/thread/682498
if you don't want to see the error then 

Replace this 👇

https://github.com/watery-desert/UnsplashPhotosApp/blob/c48a5149cf941d557b7600532d5057a1b58dda0d/UnsplashPhotosApp/Source/Views/HelperViews/PhotoTile.swift#L26

```swift
Image(systemName: "exclamationmark.triangle")
    .padding()
    .font(.largeTitle)
```
with this 👇

```swift
EmptyView()
```
    
                    


## Illustration Credit

<a href='https://www.freepik.com/vectors/people'>People vector created by iwat1929 - www.freepik.com</a>
<div>
