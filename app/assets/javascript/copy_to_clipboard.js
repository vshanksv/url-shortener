const copyContent = async () => {
    console.log(window.location.protocol === 'http:')
    let copyText = document.getElementById('copy-text');
    if (window.location.protocol === 'http:') {
        copyText.focus();
        copyText.select();
        try {
            let success_flag = document.execCommand('copy');
            if (success_flag) {
                showSuccess();

                // reset to default state
                setTimeout(() => {
                    resetToDefault();
                }, 2000);
            }
        } catch (error) {
            console.log('Fallback: Oops, unable to copy', error)
        }
    } else {
        navigator.clipboard.writeText(copyText.value).then(function() {
            console.log('Content copied to clipboard');
            showSuccess();

            // reset to default state
            setTimeout(() => {
                resetToDefault();
            }, 2000);
        }, function (error) {
            console.error('Failed to copy: ', error);
        });
    }
}

const showSuccess = () => {
    let defaultMessage = document.getElementById('default-message');
    let successMessage = document.getElementById('success-message');

    defaultMessage.classList.add('hidden');
    successMessage.classList.remove('hidden');
}

const resetToDefault = () => {
    let defaultMessage = document.getElementById('default-message');
    let successMessage = document.getElementById('success-message');

    defaultMessage.classList.remove('hidden');
    successMessage.classList.add('hidden');
}