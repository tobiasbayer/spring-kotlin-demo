<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.css"
          crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

    <title>Disruptive Guestbook</title>
</head>
<body>

<div id="app">
    <nav class="navbar sticky-top navbar-light bg-light">
        <div class="form-inline">

            <div class="col-auto">
                <label class="sr-only col-form-label" for="inlineFormInputGroupUsername2">Username</label>
                <div class="input-group mb-2 mr-lg-2">
                    <div class="input-group-prepend">
                        <div class="input-group-text">@</div>
                    </div>
                    <input v-model="username" type="text" class="form-control" id="inlineFormInputGroupUsername2"
                           placeholder="Horst">
                </div>
            </div>

            <div class="col-auto extrabreit">
                <label class="sr-only col-form-label" for="inlineFormInputName2">Text</label>
                <input v-model="text" type="text" class="form-control mb-2 mr-lg-2 input-extrabreit" id="inlineFormInputName2"
                       placeholder="Nachricht #hashtag">
            </div>

            <div class="col-auto">
                <button @click="createMessage" class="btn btn-primary mb-2">Submit</button>
            </div>
        </div>
    </nav>


    <div style="margin-left: 30%; margin-right: 30%;">
        <div class="card mb-3" v-for="message in messages">
            <div class="card-body">
                <h5 v-if="message.fromUser" class="card-title">{{ message.fromUser }}</h5>
                <p class="card-text">{{ message.text }}</p>
                <p class="card-text">
                    <small class="text-muted">{{ message.createdAt}}</small>
                </p>
            </div>
            <div v-if="message.giphyLink" style="width:100%;height:0;padding-bottom:65%;position:relative;">
                <iframe :src="message.giphyLink" width="100%" height="100%" style="position:absolute"
                        frameBorder="0" class="giphy-embed" allowFullScreen></iframe>
            </div>
        </div>

    </div>
</div>


<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
        integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment-with-locales.min.js"></script>
<style>
    .navbar{
        display: flex;
        justify-content: center;
    }
    .form-inline{
        width: 800px;
        display: flex;
        justify-content: center;
    }
    .extrabreit{
        flex: 1 0 auto;
    }
    .input-extrabreit{
        width: 100% !important;
    }
</style>
<script>
    var app = new Vue({
        el: '#app',
        data: {
            messages: [],
        },
        methods: {
            refreshMessages: function () {
                fetch("${endpoint}/messages")
                    .then(res => res.json())
            .then(res => res.reverse())
            .then(res => this.messages = res);
            },
            createMessage: function () {
                fetch("${endpoint}/messages", {
                        method: 'post',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            text: this.text,
                            fromUser: this.username
                        })
                    }
                ).then(this.refreshMessages());
            }
        },
        mounted: function() {
            this.refreshMessages();
            //Run every 3 seconds
            setInterval(function () {
                this.refreshMessages();
            }.bind(this), 3000);
        }
    })
</script>
</body>
</html>
