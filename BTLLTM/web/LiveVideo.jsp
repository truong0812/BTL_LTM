<%-- 
    Document   : LiveVideo
    Created on : Nov 1, 2023, 7:37:53 AM
    Author     : Ad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Video</title>
        <style>
            html,body{
                overflow: hidden;

            }
            .centered-image {
                margin-top: 20px;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                max-width: 100%;
                height: auto;
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="centered-image">
            <img id="image" alt="Received Image" style="display: block">
            <button id="pause" style="margin-top: 5px; display: block">Pause</button>
        </div>
        <script>
            var isrunning = true;
            var btn = document.getElementById("pause");

            btn.addEventListener("click", function () {
                isrunning = !isrunning;
                if (isrunning) {
                    btn.textContent = "Pause";
                } else {
                    btn.textContent = "Resume";
                }
            });

            function updateImage() {
                // Sử dụng Ajax để gửi yêu cầu lấy hình ảnh mới từ máy chủ
                if (isrunning) {
                    var xhr = new XMLHttpRequest();
                    xhr.open("GET", "livevideo", true);
                    xhr.responseType = "blob"; // Loại dữ liệu là hình ảnh

                    xhr.onload = function () {
                        if (xhr.status === 200) {
                            var image = document.getElementById("image");
                            var url = window.URL || window.webkitURL;
                            image.src = url.createObjectURL(xhr.response);
                        }
                    };

                    xhr.send();
                }
            }

            
            var intervalId = setInterval(updateImage, 100); 

            
            if (!isrunning) {
                clearInterval(intervalId);
            }
        </script>
    </body>
</html>
