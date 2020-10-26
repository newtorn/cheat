FROM scratch
COPY cheat /cheat
EXPOSE 3478/tcp
EXPOSE 3478/udp
EXPOSE 5178
WORKDIR "/"
ENTRYPOINT [ "/cheat" ]
CMD ["serve"]
