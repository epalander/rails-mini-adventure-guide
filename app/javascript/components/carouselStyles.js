import { makeStyles } from '@material-ui/core/styles';

export const useStyles = makeStyles(() => ({
    card: {
        borderRadius: 5,
        padding: '2em 2em',
        margin: '0px 25px',
        height: '30rem',
        width: '65rem',
        boxShadow: '10px 10px 10px grey',
        display: 'flex',
    },
    carousel: {
        textAlign: 'center',
        paddingBottom: '3rem',
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
    },
    media: {
        height: 140,
    },
}));