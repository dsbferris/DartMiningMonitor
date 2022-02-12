FROM dart:latest

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
ADD . /app
RUN pub get --offline

# This just executes the dart program
CMD []
ENTRYPOINT ["dart", "main.dart"]

# This precompiles the app. It takes longer to build the container, but start the app faster
#RUN dart compile exe main.dart -o myapp
#CMD ["./myapp"]
