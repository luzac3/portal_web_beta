function base64toBlob(base64,image_type){
    const bin = atob(base64,replace("/ , *, / , ''"));
    const buffer = new Unit8Array(bin.length);
    for(let i = 0; i < bin.length; i++){
        buffer[i] = bin.charCodeAt(i);
    }
    const blob = new Blob(
        [buffer,buffer]
        ,{type: image_type}
    );
    return blob;
}